import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/constants/env_config.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

/// Read-only or editable map preview with markers.
/// Pass [onTap] to enable the edit overlay; leave null for read-only mode.
class MapPreviewWidget extends StatefulWidget {
  const MapPreviewWidget({
    required this.points,
    this.onTap,
    this.isReadOnly = true,
    super.key,
  });

  final List<LatLng> points;
  final VoidCallback? onTap;
  final bool isReadOnly;

  @override
  State<MapPreviewWidget> createState() => _MapPreviewWidgetState();
}

class _MapPreviewWidgetState extends State<MapPreviewWidget> {
  late final MapController _mapController;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant MapPreviewWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.points.length != oldWidget.points.length ||
        (widget.points.isNotEmpty &&
            oldWidget.points.isNotEmpty &&
            widget.points.first != oldWidget.points.first)) {
      if (widget.points.length > 1) {
        final bounds = LatLngBounds.fromPoints(widget.points);
        final isSinglePointArea = bounds.southWest == bounds.northEast;
        if (!isSinglePointArea) {
          _mapController.fitCamera(
            CameraFit.bounds(
              bounds: bounds,
              padding: const EdgeInsets.all(AppDimensions.xl),
            ),
          );
        } else {
          _mapController.move(widget.points.first, 14);
        }
      } else if (widget.points.isNotEmpty) {
        _mapController.move(widget.points.first, 14);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    CameraFit? cameraFit;
    if (widget.points.length > 1) {
      final bounds = LatLngBounds.fromPoints(widget.points);
      final isSinglePointArea = bounds.southWest == bounds.northEast;
      if (!isSinglePointArea) {
        cameraFit = CameraFit.bounds(
          bounds: bounds,
          padding: const EdgeInsets.all(AppDimensions.xl),
        );
      }
    }

    return SizedBox(
      height: 180,
      child: Stack(
        fit: StackFit.expand,
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: widget.points.first,
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
                markers: widget.points
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
          if (widget.isReadOnly) ...[
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: widget.onTap,
                  child: const SizedBox.shrink(),
                ),
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
