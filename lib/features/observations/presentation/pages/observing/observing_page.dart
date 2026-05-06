import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/constants/app_routes.dart';
import 'package:noctambuls/core/di/injection_container.dart';
import 'package:noctambuls/core/presentation/widgets/app_button.dart';
import 'package:noctambuls/core/presentation/widgets/app_button_fab.dart';
import 'package:noctambuls/core/presentation/widgets/app_sheet.dart';
import 'package:noctambuls/core/presentation/widgets/bottom_nav_bar.dart';
import 'package:noctambuls/features/guide/presentation/bloc/catalog_sync_bloc.dart';
import 'package:noctambuls/features/guide/presentation/bloc/catalog_sync_state.dart';
import 'package:noctambuls/features/guide/presentation/pages/guide/widgets/catalog_sync_requiered_view.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_lifecycle_bloc.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_lifecycle_event.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_lifecycle_state.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_observation_bloc.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_observation_event.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_observation_state.dart';
import 'package:noctambuls/features/observations/presentation/cubit/stopwatch_cubit.dart';
import 'package:noctambuls/features/observations/presentation/pages/observation_form/observation_form_page.dart';
import 'package:noctambuls/features/observations/presentation/pages/observing/widgets/empty_observations.dart';
import 'package:noctambuls/features/observations/presentation/pages/observing/widgets/observation_card.dart';
import 'package:noctambuls/features/observations/presentation/pages/observing/widgets/stopwatch_display.dart';
import 'package:noctambuls/features/observations/presentation/shared_widgets/popup_menu_observing.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class ObservingPage extends StatelessWidget {
  const ObservingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SessionLifecycleBloc, SessionLifecycleState>(
      listenWhen: (prev, curr) =>
          curr is SessionNavigatingToReview || curr is SessionLifecycleIdle,
      listener: (context, state) {
        if (state is SessionNavigatingToReview) {
          context.pushReplacement(AppRoutes.review, extra: state.session);
        } else if (state is SessionLifecycleIdle) {
          if (ModalRoute.of(context)?.isCurrent == true) {
            context.pop();
          }
        }
      },
      buildWhen: (prev, curr) {
        if (curr is! SessionObserving) return false;
        final prevId = prev is SessionObserving ? prev.session.id : null;
        return prevId != curr.session.id;
      },
      builder: (context, state) {
        if (state is! SessionObserving) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return BlocProvider(
          create: (_) =>
              sl<SessionObservationBloc>(param1: state.session.id)
                ..add(WatchObservations()),
          child: _ObservingContent(session: state.session),
        );
      },
    );
  }
}

class _ObservingContent extends StatelessWidget {
  const _ObservingContent({required this.session});

  final ObservationSession session;

  Future<void> _confirmDelete(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final isConfirmed = await AppSheet.showConfirm(
      context: context,
      title: l10n.confirmDeleteSessionTitle,
      message: l10n.confirmDeleteSessionMessage,
      confirmText: l10n.confirmDelete,
      cancelText: l10n.cancel,
      isDestructive: true,
    );
    if (!context.mounted) return;

    if (isConfirmed == true) {
      context.read<SessionLifecycleBloc>().add(DeleteSession());
    }
  }

  Future<void> _goToReview(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;

    final isConfirmed = await AppSheet.showConfirm(
      context: context,
      title: l10n.stopAndReviewTitle,
      message: l10n.stopAndReviewMessage,
      confirmText: l10n.stopAndReviewConfirm,
      cancelText: l10n.cancel,
    );

    if (!context.mounted) return;

    if (isConfirmed == true) {
      context.read<SessionLifecycleBloc>().add(StopObservationPhase());
    }
  }

  Future<void> _pickGlobalDate(BuildContext context) async {
    final now = DateTime.now();
    final lifecycleState =
        context.read<SessionLifecycleBloc>().state as SessionObserving;
    final current =
        lifecycleState.selectedObservationDate ??
        session.startTime ??
        now;

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: current.isAfter(now) ? now : current,
      firstDate: DateTime(2020),
      lastDate: now,
    );
    if (!context.mounted || pickedDate == null) return;

    context
        .read<SessionLifecycleBloc>()
        .add(ChangeObservationDate(pickedDate));
  }

  void _openForm(BuildContext context) {
    final lifecycleState =
        context.read<SessionLifecycleBloc>().state as SessionObserving;
    final globalDate =
        session.canEditObservationDate
            ? (lifecycleState.selectedObservationDate ??
                session.startTime ??
                DateTime.now())
            : null;

    unawaited(
      context.push(
        AppRoutes.observationForm,
        extra: ObservationFormArgs(
          session: session,
          sessionBloc: context.read<SessionObservationBloc>(),
          globalDate: globalDate,
          onGlobalDateChanged: session.canEditObservationDate
              ? (date) => context
                  .read<SessionLifecycleBloc>()
                  .add(ChangeObservationDate(date))
              : null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final showCatalogRequiredView = context.select<CatalogSyncBloc, bool>((
      bloc,
    ) {
      final state = bloc.state;

      if (state is CatalogSyncFailure) {
        return state.isCatalogEmpty;
      }
      if (state is CatalogSyncInProgress) {
        return state.isCatalogEmpty;
      }

      return false;
    });

    return BlocProvider(
      create: (_) => StopwatchCubit(
        startTime: session.startTime ?? DateTime.now(),
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(onPressed: () => context.pop()),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.observingTitle),
              const StopwatchDisplay(),
            ],
          ),
          actions: [PopupMenuObserving(session: session)],
        ),
        body: SafeArea(
          child: showCatalogRequiredView
              ? const CatalogSyncRequiredView()
              : _ObservationListBody(session: session),
        ),
        floatingActionButton: AppButtonFab.large(
          onPressed: () => _openForm(context),
          icon: Icons.add,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        bottomNavigationBar: BottomNavBar(
          child: Row(
            children: [
              AppButton.destructiveSoft(
                icon: Icons.delete_outline,
                onPressed: () => _confirmDelete(context),
              ),
              if (session.canEditObservationDate) ...[
                const SizedBox(width: AppDimensions.sm),
                IconButton(
                  icon: const Icon(Icons.calendar_today_outlined),
                  tooltip: l10n.changeDateLabel,
                  onPressed: () => _pickGlobalDate(context),
                ),
              ],
              const Spacer(),
              AppButton(
                label: l10n.stopAndReview,
                icon: Icons.stop_circle_outlined,
                onPressed: () => _goToReview(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ObservationListBody extends StatelessWidget {
  const _ObservationListBody({required this.session});

  final ObservationSession session;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionObservationBloc, SessionObservationState>(
      builder: (context, state) {
        if (state is ObservationsLoaded) {
          if (state.observations.isEmpty) {
            return const EmptyObservations();
          }

          return ListView.builder(
            padding: const EdgeInsets.all(AppDimensions.md),
            itemCount: state.observations.length,
            itemBuilder: (context, index) {
              final record = state.observations[index];
              final bird = state.birdsMap[record.speciesId];

              return ObservationCard(
                record: state.observations[index],
                bird: bird!,
                session: session,
              );
            },
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
