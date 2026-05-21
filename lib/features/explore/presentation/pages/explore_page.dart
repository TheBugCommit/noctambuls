import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/data/error/infrastrocture_failures.dart';
import 'package:noctambuls/core/domain/error/failure.dart';
import 'package:noctambuls/core/presentation/bloc/location/location_bloc.dart';
import 'package:noctambuls/core/presentation/bloc/location/location_event.dart';
import 'package:noctambuls/core/presentation/bloc/location/location_state.dart';
import 'package:noctambuls/core/presentation/widgets/app_button.dart';
import 'package:noctambuls/core/presentation/widgets/app_button_fab.dart';
import 'package:noctambuls/core/presentation/widgets/app_map_view.dart';
import 'package:noctambuls/core/presentation/widgets/app_sheet.dart';
import 'package:noctambuls/core/presentation/widgets/page_loading_overlay.dart';
import 'package:noctambuls/features/explore/domain/entities/bubble_cluster.dart';
import 'package:noctambuls/features/explore/domain/entities/map_bounds.dart';
import 'package:noctambuls/features/explore/presentation/bloc/explore_bloc.dart';
import 'package:noctambuls/features/explore/presentation/bloc/explore_event.dart';
import 'package:noctambuls/features/explore/presentation/bloc/explore_state.dart';
import 'package:noctambuls/features/explore/presentation/widgets/explore_bottom_sheet.dart';
import 'package:noctambuls/features/guide/presentation/bloc/catalog_sync_bloc.dart';
import 'package:noctambuls/features/guide/presentation/bloc/catalog_sync_state.dart';
import 'package:noctambuls/features/guide/presentation/pages/guide/widgets/catalog_sync_requiered_view.dart';
import 'package:noctambuls/features/observations/domain/enums/location_error_type.dart';
import 'package:noctambuls/features/observations/presentation/shared_widgets/location_auto_capture_mixin.dart';
import 'package:noctambuls/features/observations/presentation/shared_widgets/location_permissions_dialog.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

const _maxZoom = 11.5;

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage>
    with WidgetsBindingObserver, LocationAutoCaptureMixin {
  final MapController _mapController = MapController();
  StreamSubscription<MapEvent>? _mapEventSubscription;
  LatLng? _userLocation;
  bool _isSheetVisible = true;

  @override
  bool get shouldRetryLocationCapture {
    final locationState = context.read<LocationBloc>().state;
    if (locationState is LocationLoadFailure &&
        locationState.failure is PermissionDeniedFailure) {
      return false;
    }
    return true;
  }

  @override
  Future<void> onResumedLocationCapture() async {
    if (!mounted) return;
    context.read<LocationBloc>().add(LocationRequested());
  }

  @override
  void initState() {
    super.initState();
    _mapEventSubscription = _mapController.mapEventStream
        .where(
          (e) => e is MapEventMoveEnd || e is MapEventScrollWheelZoom,
        )
        .listen((_) {
          if (!mounted) return;
          try {
            final bounds = _mapController.camera.visibleBounds;
            final mapBounds = MapBounds(
              minLat: bounds.south,
              maxLat: bounds.north,
              minLon: bounds.west,
              maxLon: bounds.east,
            );
            context.read<ExploreBloc>().add(
              ExploreMapCameraChanged(
                bounds: mapBounds,
                zoom: _mapController.camera.zoom,
              ),
            );
          } catch (_) {}
        });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<LocationBloc>().add(LocationRequested());
    });
  }

  @override
  void dispose() {
    unawaited(_mapEventSubscription?.cancel());
    _mapController.dispose();
    super.dispose();
  }

  LocationErrorType _mapFailureToType(Failure failure) {
    if (failure is PermissionDeniedFailure) {
      return LocationErrorType.permissionDenied;
    }
    return LocationErrorType.gpsDisabled;
  }

  List<Marker> _buildBubbleMarkers(ExploreState state) {
    if (state.visibleClusters.isEmpty) return const [];

    final maxCount = state.visibleClusters.fold(
      0,
      (m, c) => c.count > m ? c.count : m,
    );
    if (maxCount == 0) return const [];

    final markers = state.visibleClusters.map((cluster) {
      final radius = 8.0 + 32.0 * sqrt(cluster.count / maxCount);
      final isSelected =
          state.tappedCluster != null &&
          state.tappedCluster!.lat == cluster.lat &&
          state.tappedCluster!.lon == cluster.lon;

      return Marker(
        point: LatLng(cluster.lat, cluster.lon),
        width: radius * 2 + 10,
        height: radius * 2 + 10,
        alignment: Alignment.center,
        child: _BubbleMarker(
          key: ValueKey('${cluster.lat}_${cluster.lon}'),
          cluster: cluster,
          radius: radius,
          isSelected: isSelected,
          onTap: () {
            if (isSelected) {
              context.read<ExploreBloc>().add(
                const ExploreBubbleTapped(cluster: null),
              );
            } else {
              context.read<ExploreBloc>().add(
                ExploreBubbleTapped(cluster: cluster),
              );
            }
          },
        ),
      );
    }).toList();

    if (state.tappedCluster != null) {
      final selectedIndex = state.visibleClusters.indexWhere(
        (c) =>
            c.lat == state.tappedCluster!.lat &&
            c.lon == state.tappedCluster!.lon,
      );

      if (selectedIndex != -1) {
        final selectedMarker = markers.removeAt(selectedIndex);
        markers.add(selectedMarker);
      }
    }

    return markers;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final showCatalogRequired = context.select<CatalogSyncBloc, bool>((bloc) {
      final s = bloc.state;
      if (s is CatalogSyncFailure) return s.isCatalogEmpty;
      if (s is CatalogSyncInProgress) return s.isCatalogEmpty;
      return false;
    });

    if (showCatalogRequired) {
      return const Scaffold(body: CatalogSyncRequiredView());
    }

    return BlocListener<LocationBloc, LocationState>(
      listener: (context, state) {
        if (state is LocationLoadSuccess) {
          setState(() {
            _userLocation = LatLng(
              state.position.latitude,
              state.position.longitude,
            );
          });
        } else if (state is LocationLoadFailure) {
          if (state.failure is PermissionDeniedFailure ||
              state.failure is GpsDisabledFailure) {
            unawaited(
              LocationPermissionsDialog.showLocationErrorDialog(
                context,
                _mapFailureToType(state.failure),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(l10n.locationErrorTimeout),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        }
      },
      child: BlocBuilder<ExploreBloc, ExploreState>(
        builder: (context, state) {
          final showNoInternet = !state.isConnected;

          return Scaffold(
            body: Stack(
              children: [
                if (showNoInternet)
                  _ExploreNoInternetWidget()
                else
                  AppMapView(
                    mapController: _mapController,
                    initialZoom: _maxZoom,
                    maxZoom: _maxZoom,
                    userLocation: _userLocation,
                    markers: _buildBubbleMarkers(state),
                    middleColumnAction: AppButtonFab.regular(
                      heroTag: 'explore_sheet_toggle_btn',
                      icon: _isSheetVisible
                          ? Icons.zoom_out_map
                          : Icons.zoom_in_map,
                      onPressed: () =>
                          setState(() => _isSheetVisible = !_isSheetVisible),
                    ),
                    onTap: (tapPosition, point) {
                      if (state.tappedCluster != null) {
                        context.read<ExploreBloc>().add(
                          const ExploreBubbleTapped(cluster: null),
                        );
                      }
                    },
                    onMapReady: () {
                      if (!mounted) return;
                      final bounds = _mapController.camera.visibleBounds;
                      final mapBounds = MapBounds(
                        minLat: bounds.south,
                        maxLat: bounds.north,
                        minLon: bounds.west,
                        maxLon: bounds.east,
                      );
                      context.read<ExploreBloc>().add(
                        ExploreMapCameraChanged(
                          bounds: mapBounds,
                          zoom: _mapController.camera.zoom,
                        ),
                      );
                    },
                    onHelp: () {
                      final l10n = AppLocalizations.of(context)!;
                      unawaited(
                        AppSheet.showInfo(
                          context: context,
                          title: l10n.exploreMapPickerHelpTitle,
                          message: l10n.exploreMapPickerHelpContent,
                          buttonText: l10n.understood,
                        ),
                      );
                    },
                  ),
                if (_isSheetVisible)
                  NotificationListener<DraggableScrollableNotification>(
                    onNotification: (n) {
                      if (n.extent < 0.12) {
                        setState(() => _isSheetVisible = false);
                      }
                      return false;
                    },
                    child: const Positioned.fill(child: ExploreBottomSheet()),
                  ),

                if (state.isSyncing) const LoadingOverlay(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ExploreNoInternetWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.wifi_off_outlined,
              size: AppDimensions.iconLg * 2,
              color: colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: AppDimensions.sm),
            Text(
              l10n.exploreNoInternet,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppDimensions.xs),
            Text(
              l10n.exploreNoInternetDesc,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppDimensions.lg),
            AppButton.primary(
              label: l10n.retry,
              icon: Icons.refresh,
              onPressed: () =>
                  context.read<ExploreBloc>().add(const ExploreRetrySync()),
            ),
          ],
        ),
      ),
    );
  }
}

class _BubbleMarker extends StatelessWidget {
  const _BubbleMarker({
    required this.cluster,
    required this.radius,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final BubbleCluster cluster;
  final double radius;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onTap: onTap,
          child: AnimatedScale(
            scale: isSelected ? 1.3 : 1.0,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutBack,
            child: Center(
              child: Container(
                width: radius * 2,
                height: radius * 2,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected
                      ? Colors.red.withValues(alpha: 0.6)
                      : Colors.redAccent.withValues(alpha: 0.35),
                  border: Border.all(
                    color: Colors.redAccent,
                    width: isSelected ? 2.5 : 2,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.3),
                            blurRadius: 6,
                            spreadRadius: 1,
                          ),
                        ]
                      : null,
                ),
              ),
            ),
          ),
        ),
        if (isSelected)
          _BubbleTooltip(
            cluster: cluster,
            radius: radius,
            isSelected: isSelected,
          ),
      ],
    );
  }
}

class _BubbleTooltip extends StatelessWidget {
  const _BubbleTooltip({
    required this.cluster,
    required this.radius,
    required this.isSelected,
  });

  final BubbleCluster cluster;
  final double radius;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: (radius * 2) * 1.3 + 8,
      child: AnimatedOpacity(
        opacity: isSelected ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 150),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.visibility_outlined,
                color: Colors.white70,
                size: AppDimensions.iconXs,
              ),
              const SizedBox(width: AppDimensions.sm),
              Text(
                '${cluster.count}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
