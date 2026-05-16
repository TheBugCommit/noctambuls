import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/constants/env_config.dart';
import 'package:noctambuls/core/presentation/bloc/url/url_bloc.dart';
import 'package:noctambuls/core/presentation/bloc/url/url_event.dart';
import 'package:noctambuls/core/presentation/widgets/app_button_fab.dart';
import 'package:noctambuls/core/presentation/widgets/app_sheet.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class AppMapView extends StatefulWidget {
  const AppMapView({
    required this.mapController,
    this.initialCenter,
    this.initialZoom = 15.0,
    this.maxZoom = 18.0,
    this.markers = const [],
    this.userLocation,
    this.onLongPress,
    this.onTap,
    this.bottomAction,
    this.middleColumnAction,
    super.key,
  });

  final MapController mapController;
  final LatLng? initialCenter;
  final double initialZoom;
  final double maxZoom;
  final List<Marker> markers;
  final LatLng? userLocation;
  final void Function(TapPosition, LatLng)? onLongPress;
  final void Function(TapPosition, LatLng)? onTap;
  final Widget? bottomAction;
  final Widget? middleColumnAction;

  @override
  State<AppMapView> createState() => _AppMapViewState();
}

class _AppMapViewState extends State<AppMapView> with TickerProviderStateMixin {
  bool _isTopoLayer = false;
  AnimationController? _moveController;
  bool _hasAutoCentered = false;
  bool _isMapReady = false;

  @override
  void dispose() {
    _moveController?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(AppMapView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (_isMapReady &&
        !_hasAutoCentered &&
        widget.initialCenter == null &&
        widget.userLocation != null) {
      _hasAutoCentered = true;
      _centerOnUser();
    }
  }

  String get _tileUrl =>
      _isTopoLayer ? EnvConfig.openTopoMapTiles : EnvConfig.openStreetMapTiles;

  void _showHelp(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    unawaited(
      AppSheet.showInfo(
        context: context,
        title: l10n.mapPickerHelpTitle,
        message: l10n.mapPickerHelpContent,
        buttonText: l10n.understood,
      ),
    );
  }

  void _centerOnUser() {
    if (widget.userLocation != null) {
      _animatedMapMove(widget.userLocation!, min(16.0, widget.maxZoom));
    }
  }

  bool isValidCoordinate(double value) {
    return value.isFinite && !value.isNaN;
  }

  void _animatedMapMove(LatLng destLocation, double destZoom) {
    if (!_isMapReady) return;

    final camera = widget.mapController.camera;

    if (!isValidCoordinate(camera.center.latitude) ||
        !isValidCoordinate(camera.center.longitude) ||
        !isValidCoordinate(destLocation.latitude) ||
        !isValidCoordinate(destLocation.longitude)) {
      return;
    }

    _moveController?.dispose();
    _moveController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    final latTween = Tween<double>(
      begin: camera.center.latitude,
      end: destLocation.latitude,
    );
    final lngTween = Tween<double>(
      begin: camera.center.longitude,
      end: destLocation.longitude,
    );
    final zoomTween = Tween<double>(begin: camera.zoom, end: destZoom);

    final Animation<double> animation = CurvedAnimation(
      parent: _moveController!,
      curve: Curves.fastOutSlowIn,
    );

    _moveController!.addListener(() {
      final currentLat = latTween.evaluate(animation);
      final currentLng = lngTween.evaluate(animation);
      final currentZoom = zoomTween.evaluate(animation);

      if (isValidCoordinate(currentLat) &&
          isValidCoordinate(currentLng) &&
          !currentZoom.isNaN) {
        try {
          widget.mapController.move(
            LatLng(currentLat, currentLng),
            currentZoom,
          );
        } catch (_) {}
      }
    });

    unawaited(_moveController!.forward());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    const defaultCenter = LatLng(41.8, 1.5); // Catalunya

    return Stack(
      children: [
        FlutterMap(
          mapController: widget.mapController,
          options: MapOptions(
            initialCenter: widget.initialCenter ?? defaultCenter,
            initialZoom: widget.initialZoom,
            onLongPress: widget.onLongPress,
            onTap: widget.onTap,
            onMapReady: () {
              _isMapReady = true;
              if (!_hasAutoCentered &&
                  widget.initialCenter == null &&
                  widget.userLocation != null) {
                _hasAutoCentered = true;
                _centerOnUser();
              }
            },
            onPositionChanged: (position, hasGesture) {
              if (hasGesture && _moveController?.isAnimating == true) {
                _moveController?.stop();
              }
            },
            minZoom: 3.0,
            maxZoom: widget.maxZoom,
            cameraConstraint: CameraConstraint.contain(
              bounds: LatLngBounds(
                const LatLng(-90, -180),
                const LatLng(90, 180),
              ),
            ),
            interactionOptions: const InteractionOptions(
              flags:
                  InteractiveFlag.all &
                  ~InteractiveFlag.rotate &
                  ~InteractiveFlag.flingAnimation,
            ),
          ),
          children: [
            TileLayer(
              urlTemplate: _tileUrl,
              userAgentPackageName: EnvConfig.packageName,
              retinaMode: false,
              maxNativeZoom: 18,
            ),

            if (widget.userLocation != null &&
                !widget.userLocation!.latitude.isNaN &&
                !widget.userLocation!.longitude.isNaN)
              MarkerLayer(
                markers: [
                  Marker(
                    point: widget.userLocation!,
                    width: AppDimensions.lg,
                    height: AppDimensions.lg,
                    rotate: true,
                    alignment: Alignment.center,
                    child: Container(
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: colorScheme.surface,
                          width: 3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: colorScheme.primary.withValues(alpha: 0.4),
                            blurRadius: AppDimensions.sm,
                            spreadRadius: AppDimensions.xs / 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

            MarkerLayer(markers: widget.markers),

            if (widget.bottomAction != null) widget.bottomAction!,

            RichAttributionWidget(
              attributions: [
                if (_isTopoLayer) ...[
                  TextSourceAttribution(
                    EnvConfig.openTopoMapTextAttribute,
                    onTap: () => context.read<UrlBloc>().add(
                      const OpenUrlRequested(EnvConfig.openStreetMapCopyright),
                    ),
                  ),
                  TextSourceAttribution(
                    EnvConfig.openTopoMapStyleAttribute,
                    onTap: () => context.read<UrlBloc>().add(
                      const OpenUrlRequested(EnvConfig.openTopoMapAbout),
                    ),
                  ),
                ] else ...[
                  TextSourceAttribution(
                    EnvConfig.openStreetMapTextAttribute,
                    onTap: () => context.read<UrlBloc>().add(
                      const OpenUrlRequested(EnvConfig.openStreetMapCopyright),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),

        Positioned(
          top: AppDimensions.md,
          left: AppDimensions.md,
          child: SafeArea(
            child: AppButtonFab.regular(
              heroTag: 'map_help_btn',
              icon: Icons.help_outline,
              style: AppButtonFabStyle.tertiary,
              onPressed: () => _showHelp(context),
            ),
          ),
        ),

        Positioned(
          top: AppDimensions.md,
          right: AppDimensions.md,
          child: SafeArea(
            child: Column(
              children: [
                AppButtonFab.regular(
                  heroTag: 'map_layer_btn',
                  icon: _isTopoLayer
                      ? Icons.map_outlined
                      : Icons.layers_outlined,
                  onPressed: () => setState(() => _isTopoLayer = !_isTopoLayer),
                ),
                const SizedBox(height: AppDimensions.sm),
                if (widget.middleColumnAction != null) ...[
                  widget.middleColumnAction!,
                  const SizedBox(height: AppDimensions.sm),
                ],
                AppButtonFab.regular(
                  heroTag: 'map_location_btn',
                  icon: Icons.my_location,
                  style: widget.userLocation != null
                      ? AppButtonFabStyle.primary
                      : AppButtonFabStyle.surface,
                  onPressed: widget.userLocation != null ? _centerOnUser : null,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
