import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/constants/app_routes.dart';
import 'package:noctambuls/core/constants/env_config.dart';
import 'package:noctambuls/core/domain/entities/geo_position.dart';
import 'package:noctambuls/core/presentation/bloc/connectivity/connectivity_bloc.dart';
import 'package:noctambuls/core/presentation/bloc/connectivity/connectivity_event.dart';
import 'package:noctambuls/core/presentation/bloc/connectivity/connectivity_state.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_observation_bloc.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_observation_state.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_review_bloc.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_review_event.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class SessionLocationSection extends StatefulWidget {
  const SessionLocationSection({
    required this.session,
    required this.showError,
    super.key,
  });

  final ObservationSession session;
  final bool showError;

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
    if (widget.session.isIncidental) return;

    final result = await context.push<GeoPosition>(
      AppRoutes.mapPicker,
      extra: widget.session.location,
    );
    if (!context.mounted || result == null) return;

    context.read<SessionReviewBloc>().add(
      ReviewUpdateProperties(location: result),
    );
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

              var hasConnection = false;
              if (networkState is NetworkActionSuccess) {
                hasConnection = true;
              }

              if (!hasConnection) {
                return const _NoInternetPlaceholder();
              }

              return BlocBuilder<
                SessionObservationBloc,
                SessionObservationState
              >(
                builder: (context, obsState) {
                  final points = _extractMapPoints(obsState);

                  if (points.isNotEmpty) {
                    return _MapPreview(
                      points: points,
                      isIncidental: widget.session.isIncidental,
                      onTap: () => _openMapPicker(context),
                    );
                  }

                  return _NoLocationPlaceholder(
                    hasError: hasError,
                    isIncidental: widget.session.isIncidental,
                    onOpenMap: () => _openMapPicker(context),
                  );
                },
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

  List<LatLng> _extractMapPoints(SessionObservationState obsState) {
    final points = <LatLng>[];

    if (widget.session.isIncidental) {
      if (obsState is ObservationsLoaded) {
        for (final obs in obsState.observations) {
          if (obs.location != null) {
            points.add(LatLng(obs.location!.latitude, obs.location!.longitude));
          }
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
}

class _MapPreview extends StatelessWidget {
  const _MapPreview({
    required this.points,
    required this.isIncidental,
    required this.onTap,
  });

  final List<LatLng> points;
  final bool isIncidental;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    CameraFit? cameraFit;
    if (points.length > 1) {
      cameraFit = CameraFit.bounds(
        bounds: LatLngBounds.fromPoints(points),
        padding: const EdgeInsets.all(AppDimensions.xl),
      );
    }

    return SizedBox(
      height: 180,
      child: Stack(
        fit: StackFit.expand,
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: points.first,
              initialZoom: 14,
              initialCameraFit: cameraFit,
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.none,
              ),
            ),
            children: [
              TileLayer(
                urlTemplate: EnvConfig.openStreetMapTiles,
                userAgentPackageName: EnvConfig.packageName,
              ),
              MarkerLayer(
                markers: points
                    .map(
                      (p) => Marker(
                        point: p,
                        width: AppDimensions.xl,
                        height: AppDimensions.xl,
                        child: const Icon(
                          Icons.location_on,
                          color: Colors.redAccent,
                          size: AppDimensions.xl,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),

          if (!isIncidental) ...[
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(onTap: onTap, child: const SizedBox.shrink()),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.sm,
                  vertical: AppDimensions.xs,
                ),
                color: theme.colorScheme.scrim.withValues(alpha: 0.65),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.edit_location_alt_outlined,
                      color: theme.colorScheme.onInverseSurface,
                      size: AppDimensions.iconSm,
                    ),
                    const SizedBox(width: AppDimensions.xs),
                    Text(
                      l10n.reviewLocationModify,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onInverseSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _NoLocationPlaceholder extends StatelessWidget {
  const _NoLocationPlaceholder({
    required this.hasError,
    required this.isIncidental,
    required this.onOpenMap,
  });

  final bool hasError;
  final bool isIncidental;
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
          if (!isIncidental) ...[
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

class _NoInternetPlaceholder extends StatelessWidget {
  const _NoInternetPlaceholder();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(AppDimensions.xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.wifi_off_outlined,
            size: AppDimensions.iconXl,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: AppDimensions.sm),
          Text(
            l10n.reviewLocationNoInternet,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppDimensions.xs),
          Text(
            l10n.reviewLocationNoInternetDesc,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
