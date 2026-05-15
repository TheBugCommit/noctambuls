import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/constants/app_routes.dart';
import 'package:noctambuls/core/domain/entities/geo_position.dart';
import 'package:noctambuls/core/presentation/bloc/connectivity/connectivity_bloc.dart';
import 'package:noctambuls/core/presentation/bloc/connectivity/connectivity_event.dart';
import 'package:noctambuls/core/presentation/bloc/connectivity/connectivity_state.dart';
import 'package:noctambuls/core/presentation/widgets/map_preview_widget.dart';
import 'package:noctambuls/core/presentation/widgets/no_internet_placeholder_widget.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_review_bloc.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_review_event.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class SessionLocationSection extends StatefulWidget {
  const SessionLocationSection({
    required this.session,
    required this.showError,
    required this.isReadOnly,
    super.key,
  });

  final ObservationSession session;
  final bool showError;
  final bool isReadOnly;

  @override
  State<SessionLocationSection> createState() => _SessionLocationSectionState();
}

class _SessionLocationSectionState extends State<SessionLocationSection> {
  @override
  void initState() {
    super.initState();
    context.read<ConnectivityBloc>().add(const CheckInternetConnectionEvent());
  }

  Future<void> _openMapPicker(BuildContext context) async {
    if (widget.session.isIncidental || widget.isReadOnly) return;

    final result = await context.push<GeoPosition>(
      AppRoutes.mapPicker,
      extra: widget.session.location,
    );
    if (!context.mounted || result == null) return;

    context.read<SessionReviewBloc>().add(
      ReviewUpdateProperties(location: result),
    );
  }

  List<LatLng> _extractMapPoints() {
    final points = <LatLng>[];

    if (widget.session.isIncidental) {
      for (final obs in widget.session.observations) {
        if (obs.location != null) {
          points.add(LatLng(obs.location!.latitude, obs.location!.longitude));
        }
      }
    } else {
      if (widget.session.location != null) {
        points.add(
          LatLng(
            widget.session.location!.latitude,
            widget.session.location!.longitude,
          ),
        );
      }
    }
    return points;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final hasError = widget.showError;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.session.isIncidental
              ? l10n.reviewLocationIncidentalTitle
              : l10n.reviewLocationSessionTitle,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppDimensions.sm),

        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
            side: BorderSide(
              color: hasError
                  ? theme.colorScheme.error
                  : theme.colorScheme.outlineVariant,
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: BlocBuilder<ConnectivityBloc, ConnectivityState>(
            builder: (context, networkState) {
              if (networkState is NetworkActionInitial ||
                  networkState is NetworkActionLoading) {
                return const SizedBox(
                  height: 180,
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (networkState is! NetworkActionSuccess) {
                return const NoInternetPlaceholderWidget();
              }

              final points = _extractMapPoints();

              if (points.isNotEmpty) {
                return MapPreviewWidget(
                  points: points,
                  isReadOnly: widget.isReadOnly,
                  onTap: (widget.session.isIncidental)
                      ? null
                      : () => _openMapPicker(context),
                );
              }

              return _NoLocationPlaceholder(
                hasError: hasError,
                isIncidental: widget.session.isIncidental,
                isReadOnly: widget.isReadOnly,
                onOpenMap: () => _openMapPicker(context),
              );
            },
          ),
        ),
        if (hasError && !widget.session.isIncidental) ...[
          const SizedBox(height: AppDimensions.xs),
          Text(
            l10n.reviewLocationRequiredError,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.error,
            ),
          ),
        ],
      ],
    );
  }
}

class _NoLocationPlaceholder extends StatelessWidget {
  const _NoLocationPlaceholder({
    required this.hasError,
    required this.isIncidental,
    required this.isReadOnly,
    required this.onOpenMap,
  });

  final bool hasError;
  final bool isIncidental;
  final bool isReadOnly;
  final VoidCallback onOpenMap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(AppDimensions.lg),
      child: Column(
        children: [
          Icon(
            Icons.location_off_outlined,
            size: AppDimensions.iconXl,
            color: hasError
                ? theme.colorScheme.error
                : theme.colorScheme.outline,
          ),
          const SizedBox(height: AppDimensions.sm),
          Text(
            l10n.reviewLocationMissing,
            style: theme.textTheme.titleMedium?.copyWith(
              color: hasError ? theme.colorScheme.error : null,
            ),
          ),
          const SizedBox(height: AppDimensions.xs),
          Text(
            isIncidental
                ? l10n.reviewLocationIncidentalMissingDesc
                : l10n.reviewLocationSessionMissingDesc,
            style: theme.textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
          if (!isIncidental && !isReadOnly) ...[
            const SizedBox(height: AppDimensions.md),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: onOpenMap,
                icon: const Icon(Icons.map_outlined),
                label: Text(l10n.reviewLocationSetMap),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
