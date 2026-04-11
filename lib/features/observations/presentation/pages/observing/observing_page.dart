import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/constants/app_routes.dart';
import 'package:noctambuls/core/di/injection_container.dart';
import 'package:noctambuls/core/widgets/app_button.dart';
import 'package:noctambuls/core/widgets/app_button_fab.dart';
import 'package:noctambuls/core/widgets/bottom_nav_bar.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_lifecycle_bloc.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_lifecycle_state.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_observation_bloc.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_observation_event.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_observation_state.dart';
import 'package:noctambuls/features/observations/presentation/cubit/stopwatch_cubit.dart';
import 'package:noctambuls/features/observations/presentation/pages/observing/widgets/empty_observations.dart';
import 'package:noctambuls/features/observations/presentation/pages/observing/widgets/observation_tile.dart';
import 'package:noctambuls/features/observations/presentation/pages/observing/widgets/stopwatch_display.dart';
import 'package:noctambuls/features/observations/presentation/shared_widgets/delete_session_dialog.dart';
import 'package:noctambuls/features/observations/presentation/shared_widgets/popup_menu_observing.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class ObservingPage extends StatelessWidget {
  const ObservingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SessionLifecycleBloc, SessionLifecycleState>(
      listenWhen: (prev, curr) =>
          prev is SessionObserving && curr is! SessionObserving,
      listener: (context, state) {
        switch (state) {
          case SessionReviewing():
            context.go(AppRoutes.review);
          default:
            context.go(AppRoutes.home);
        }
      },
      buildWhen: (prev, curr) {
        final prevId = prev is SessionObserving ? prev.session.id : null;
        final currId = curr is SessionObserving ? curr.session.id : null;
        return prevId != currId;
      },
      builder: (context, state) {
        if (state is! SessionObserving) return const SizedBox.shrink();

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

  void _confirmDelete(BuildContext context) {
    unawaited(
      showDialog<void>(
        context: context,
        builder: (_) => const DeleteSessionDialog(),
      ),
    );
  }

  void _goToReview(BuildContext context) {
    unawaited(context.push(AppRoutes.review));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

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
          actions: const [PopupMenuObserving()],
        ),
        body: const _ObservationListBody(),
        floatingActionButton: AppButtonFab.large(
          onPressed: () => {},
          icon: Icons.add,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        bottomNavigationBar: BottomNavBar(
          child: Row(
            children: [
              AppButton.destructive(
                icon: Icons.delete_outline,
                onPressed: () => _confirmDelete(context),
              ),
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
  const _ObservationListBody();

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
            itemBuilder: (context, index) =>
                ObservationTile(record: state.observations[index]),
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
