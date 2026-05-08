import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/di/injection_container.dart';
import 'package:noctambuls/core/domain/entities/geo_position.dart';
import 'package:noctambuls/core/domain/enums/location_source.dart';
import 'package:noctambuls/core/domain/services/location_service.dart';
import 'package:noctambuls/core/presentation/widgets/app_button_fab.dart';
import 'package:noctambuls/core/presentation/widgets/app_map_view.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class MapPickerPage extends StatefulWidget {
  const MapPickerPage({this.initialLocation, super.key});

  final GeoPosition? initialLocation;

  @override
  State<MapPickerPage> createState() => _MapPickerPageState();
}

class _MapPickerPageState extends State<MapPickerPage> {
  final MapController _mapController = MapController();

  LatLng? _selectedPoint;
  LatLng? _userLocation;

  @override
  void initState() {
    super.initState();
    if (widget.initialLocation != null) {
      _selectedPoint = LatLng(
        widget.initialLocation!.latitude,
        widget.initialLocation!.longitude,
      );
    }

    unawaited(_fetchUserLocation());
  }

  Future<void> _fetchUserLocation() async {
    final result = await sl<LocationService>().getLocation();
    if (!mounted) return;

    result.when(
      success: (pos) {
        setState(() {
          _userLocation = LatLng(pos.latitude, pos.longitude);
          _selectedPoint ??= _userLocation;
        });
      },
      failure: (_) {},
    );
  }

  void _onConfirm() {
    if (_selectedPoint == null) return;

    final isGps =
        _userLocation != null &&
        _selectedPoint!.latitude == _userLocation!.latitude &&
        _selectedPoint!.longitude == _userLocation!.longitude;

    context.pop(
      GeoPosition(
        latitude: _selectedPoint!.latitude,
        longitude: _selectedPoint!.longitude,
        accuracy: 0,
        altitude: 0,
        altitudeAccuracy: 0,
        timestamp: DateTime.now(),
        locationSource: isGps ? LocationSource.gps : LocationSource.manual,
      ),
    );
  }

  void _resetToGps() {
    if (_userLocation == null) return;

    setState(() {
      _selectedPoint = _userLocation;
    });

    _mapController.move(_userLocation!, 16.0);
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    final canReset = _userLocation != null && _selectedPoint != _userLocation;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(l10n.mapPickerTitle),
        backgroundColor: theme.colorScheme.surface.withValues(alpha: 0.8),
        elevation: 0,
      ),
      body: AppMapView(
        mapController: _mapController,
        initialCenter: _selectedPoint,
        initialZoom: _selectedPoint != null ? 16.0 : 8.0,
        userLocation: _userLocation,
        onLongPress: (tapPosition, point) {
          setState(() {
            _selectedPoint = point;
          });
        },
        markers: [
          if (_selectedPoint != null)
            Marker(
              point: _selectedPoint!,
              width: AppDimensions.xxl,
              height: AppDimensions.xxl,
              rotate: true,
              alignment: Alignment.topCenter,
              child: Tooltip(
                message:
                    '${_selectedPoint!.latitude.toStringAsFixed(5)},'
                    ' ${_selectedPoint!.longitude.toStringAsFixed(5)}',
                triggerMode: TooltipTriggerMode.tap,
                preferBelow: false,
                child: Icon(
                  Icons.location_on,
                  color: theme.colorScheme.error,
                  size: AppDimensions.xxl,
                  shadows: [
                    Shadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: AppDimensions.sm,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
        ],
        bottomAction: Align(
          alignment: Alignment.bottomCenter,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(bottom: AppDimensions.xxl),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (canReset) ...[
                    AppButtonFab.small(
                      heroTag: 'reset_to_gps',
                      icon: Icons.restore,
                      style: AppButtonFabStyle.secondary,
                      onPressed: _resetToGps,
                    ),
                    const SizedBox(width: AppDimensions.md),
                  ],

                  AppButtonFab.extended(
                    heroTag: 'map_picker_confirm_btn',
                    onPressed: _selectedPoint == null ? null : _onConfirm,
                    icon: Icons.check_circle,
                    label: l10n.mapPickerConfirm,
                    style: _selectedPoint == null
                        ? AppButtonFabStyle.surface
                        : AppButtonFabStyle.primary,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
