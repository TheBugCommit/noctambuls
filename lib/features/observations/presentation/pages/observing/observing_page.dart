import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/constants/app_routes.dart';
import 'package:noctambuls/core/data/error/infrastrocture_failures.dart';
import 'package:noctambuls/core/domain/entities/geo_position.dart';
import 'package:noctambuls/core/domain/enums/location_source.dart';
import 'package:noctambuls/core/presentation/bloc/location/location_bloc.dart';
import 'package:noctambuls/core/presentation/bloc/location/location_event.dart';
import 'package:noctambuls/core/presentation/bloc/location/location_state.dart';
import 'package:noctambuls/core/presentation/widgets/app_button.dart';
import 'package:noctambuls/core/presentation/widgets/app_button_fab.dart';
import 'package:noctambuls/core/presentation/widgets/app_sheet.dart';
import 'package:noctambuls/core/presentation/widgets/bottom_nav_bar.dart';
import 'package:noctambuls/features/guide/presentation/bloc/catalog_sync_bloc.dart';
import 'package:noctambuls/features/guide/presentation/bloc/catalog_sync_state.dart';
import 'package:noctambuls/features/guide/presentation/pages/guide/widgets/catalog_sync_requiered_view.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/enums/location_error_type.dart';
import 'package:noctambuls/features/observations/presentation/bloc/observing_session_bloc.dart';
import 'package:noctambuls/features/observations/presentation/bloc/observing_session_event.dart';
import 'package:noctambuls/features/observations/presentation/bloc/observing_session_state.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_observation_bloc.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_observation_event.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_observation_state.dart';
import 'package:noctambuls/features/observations/presentation/cubit/stopwatch_cubit.dart';
import 'package:noctambuls/features/observations/presentation/pages/observation_form/observation_form_page.dart';
import 'package:noctambuls/features/observations/presentation/pages/observing/widgets/empty_observations.dart';
import 'package:noctambuls/features/observations/presentation/pages/observing/widgets/location_status_bar.dart';
import 'package:noctambuls/features/observations/presentation/pages/observing/widgets/observation_card.dart';
import 'package:noctambuls/features/observations/presentation/pages/observing/widgets/stopwatch_display.dart';
import 'package:noctambuls/features/observations/presentation/shared_widgets/location_auto_capture_mixin.dart';
import 'package:noctambuls/features/observations/presentation/shared_widgets/location_permissions_dialog.dart';
import 'package:noctambuls/features/observations/presentation/shared_widgets/popup_menu_observing.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class ObservingPage extends StatefulWidget {
  const ObservingPage({super.key});

  @override
  State<ObservingPage> createState() => _ObservingPageState();
}

class _ObservingPageState extends State<ObservingPage>
    with WidgetsBindingObserver, LocationAutoCaptureMixin {
  late final LocationBloc _locationBloc;

  @override
  void initState() {
    super.initState();
    _locationBloc = context.read<LocationBloc>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final state = context.read<ObservingSessionBloc>().state;
      if (state is ObservingSessionActive) {
        _manageGpsTracking(state.session);
      }
    });
  }

  @override
  void dispose() {
    _locationBloc.add(LocationTrackingStopped());
    super.dispose();
  }

  @override
  bool get shouldRetryLocationCapture {
    final state = context.read<ObservingSessionBloc>().state;
    if (state is! ObservingSessionActive) return false;

    final session = state.session;
    if (session.isIncidental) return false;
    if (session.location?.locationSource == LocationSource.manual) return false;

    return true;
  }

  @override
  Future<void> onResumedLocationCapture() async {
    _locationBloc.add(LocationTrackingStarted());
  }

  void _manageGpsTracking(ObservationSession session) {
    if (session.isIncidental) return;

    if (session.location?.locationSource == LocationSource.manual) {
      _locationBloc.add(LocationTrackingStopped());
    } else {
      _locationBloc.add(LocationTrackingStarted());
    }
  }

  Future<void> _openMap(ObservationSession session) async {
    final result = await context.push<GeoPosition>(
      AppRoutes.mapPicker,
      extra: session.location,
    );
    if (!mounted || result == null) return;

    context.read<ObservingSessionBloc>().add(
      UpdateObservingSessionLocation(geoPosition: result),
    );

    if (result.locationSource == LocationSource.manual) {
      _locationBloc.add(LocationTrackingStopped());
    } else {
      _locationBloc.add(LocationTrackingStarted());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LocationBloc, LocationState>(
      listenWhen: (prev, curr) =>
          curr is LocationLoadSuccess && curr.isTracking ||
          curr is LocationLoadFailure,
      listener: (context, state) {
        if (state is LocationLoadSuccess && state.isTracking) {
          context.read<ObservingSessionBloc>().add(
            UpdateObservingSessionLocation(geoPosition: state.position),
          );
        } else if (state is LocationLoadFailure) {
          if (state.failure is PermissionDeniedFailure ||
              state.failure is GpsDisabledFailure) {
            final errorType = state.failure is PermissionDeniedFailure
                ? LocationErrorType.permissionDenied
                : LocationErrorType.gpsDisabled;

            unawaited(
              LocationPermissionsDialog.showLocationErrorDialog(
                context,
                errorType,
              ),
            );
          }
        }
      },
      child: BlocConsumer<ObservingSessionBloc, ObservingSessionState>(
        listenWhen: (prev, curr) {
          return curr is ObservingSessionNavigatingToReview ||
              curr is ObservingSessionIdle;
        },
        listener: (context, state) {
          if (state is ObservingSessionNavigatingToReview) {
            context.pushReplacement(AppRoutes.review, extra: state.session);
          } else if (state is ObservingSessionIdle) {
            if (ModalRoute.of(context)?.isCurrent == true) {
              context.pop();
            }
          }
        },
        buildWhen: (prev, curr) {
          if (prev.runtimeType != curr.runtimeType) return true;
          if (prev is ObservingSessionActive &&
              curr is ObservingSessionActive) {
            return prev.session != curr.session ||
                prev.selectedObservationDate != curr.selectedObservationDate;
          }
          return false;
        },
        builder: (context, state) {
          if (state is! ObservingSessionActive) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          return _ObservingContent(
            session: state.session,
            onOpenMap: () => _openMap(state.session),
          );
        },
      ),
    );
  }
}

class _ObservingContent extends StatelessWidget {
  const _ObservingContent({required this.session, required this.onOpenMap});

  final ObservationSession session;
  final VoidCallback onOpenMap;

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
      context.read<ObservingSessionBloc>().add(DeleteObservingSession());
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
      context.read<ObservingSessionBloc>().add(StopObservingSession());
    }
  }

  Future<void> _pickGlobalDate(BuildContext context) async {
    final now = DateTime.now();
    final lifecycleState =
        context.read<ObservingSessionBloc>().state as ObservingSessionActive;
    final current =
        lifecycleState.selectedObservationDate ?? session.startTime ?? now;

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: current.isAfter(now) ? now : current,
      firstDate: DateTime(2020),
      lastDate: now,
    );
    if (!context.mounted || pickedDate == null) return;

    context.read<ObservingSessionBloc>().add(ChangeObservingDate(pickedDate));
    context.read<SessionObservationBloc>().add(
      UpdateAllObservationsDate(pickedDate),
    );
  }

  void _openForm(BuildContext context) {
    final lifecycleState =
        context.read<ObservingSessionBloc>().state as ObservingSessionActive;
    final globalDate = session.canEditObservationDate
        ? (lifecycleState.selectedObservationDate ??
              session.startTime ??
              DateTime.now())
        : null;

    unawaited(
      context.push(
        AppRoutes.observationForm,
        extra: ObservationFormArgs(
          session: session,
          globalDate: globalDate,
          onGlobalDateChanged: session.canEditObservationDate
              ? (date) {
                  context.read<ObservingSessionBloc>().add(
                    ChangeObservingDate(date),
                  );
                  context.read<SessionObservationBloc>().add(
                    UpdateAllObservationsDate(date),
                  );
                }
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

    final Widget content = Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => context.pop()),
        title: session.isIncidental
            ? Text(l10n.observingTitle)
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.observingTitle),
                  const StopwatchDisplay(),
                ],
              ),
        actions: [PopupMenuObserving(session: session)],
      ),
      body: SafeArea(
        child: Column(
          children: [
            if (!session.isIncidental)
              LocationStatusBar(
                session: session,
                onPressed: onOpenMap,
              ),
            Expanded(
              child: showCatalogRequiredView
                  ? const CatalogSyncRequiredView()
                  : _ObservationListBody(session: session),
            ),
          ],
        ),
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
    );

    if (!session.isIncidental) {
      return BlocProvider(
        create: (_) => StopwatchCubit(
          startTime: session.startTime ?? DateTime.now(),
        ),
        child: content,
      );
    }

    return content;
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
