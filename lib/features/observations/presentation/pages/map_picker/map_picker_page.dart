import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/data/error/infrastrocture_failures.dart';
import 'package:noctambuls/core/domain/entities/geo_position.dart';
import 'package:noctambuls/core/domain/enums/location_source.dart';
import 'package:noctambuls/core/domain/error/failure.dart';
import 'package:noctambuls/core/presentation/bloc/location/location_bloc.dart';
import 'package:noctambuls/core/presentation/bloc/location/location_event.dart';
import 'package:noctambuls/core/presentation/bloc/location/location_state.dart';
import 'package:noctambuls/core/presentation/widgets/app_button_fab.dart';
import 'package:noctambuls/core/presentation/widgets/app_map_view.dart';
import 'package:noctambuls/core/presentation/widgets/app_sheet.dart';
import 'package:noctambuls/core/presentation/widgets/page_loading_overlay.dart';
import 'package:noctambuls/features/observations/domain/enums/location_error_type.dart';
import 'package:noctambuls/features/observations/presentation/shared_widgets/location_auto_capture_mixin.dart';
import 'package:noctambuls/features/observations/presentation/shared_widgets/location_permissions_dialog.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class MapPickerPage extends StatefulWidget {
  const MapPickerPage({this.initialLocation, super.key});

  final GeoPosition? initialLocation;

  @override
  State<MapPickerPage> createState() => _MapPickerPageState();
}

class _MapPickerPageState extends State<MapPickerPage>
    with WidgetsBindingObserver, LocationAutoCaptureMixin {
  final MapController _mapController = MapController();
  late final LocationBloc _locationBloc;

  @override
  bool get shouldRetryLocationCapture => !_isManual;

  @override
  Future<void> onResumedLocationCapture() async {
    context.read<LocationBloc>().add(LocationRequested());
  }

  @override
  Future<void> onPausedLocationCapture() async {
    context.read<LocationBloc>().add(LocationTrackingStopped());
  }

  GeoPosition? _selectedLocation;
  LatLng? _userLocation;

  bool get _isManual =>
      _selectedLocation?.locationSource == LocationSource.manual;

  @override
  void initState() {
    super.initState();

    _locationBloc = context.read<LocationBloc>();

    if (widget.initialLocation != null) {
      _selectedLocation = widget.initialLocation;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final locState = context.read<LocationBloc>().state;
      if (locState is LocationLoadSuccess) {
        final pt = LatLng(
          locState.position.latitude,
          locState.position.longitude,
        );
        setState(() {
          _userLocation = pt;
          if (!_isManual) _selectedLocation = locState.position;
        });
      }

      context.read<LocationBloc>().add(LocationTrackingStarted());
    });
  }

  @override
  void dispose() {
    _locationBloc.add(LocationTrackingStopped());
    _mapController.dispose();
    super.dispose();
  }

  LocationErrorType _mapFailureToType(Failure failure) {
    if (failure is PermissionDeniedFailure) {
      return LocationErrorType.permissionDenied;
    }
    return LocationErrorType.gpsDisabled;
  }

  void _resetToGps() {
    setState(() {
      if (_userLocation != null) {
        _selectedLocation = GeoPosition(
          latitude: _userLocation!.latitude,
          longitude: _userLocation!.longitude,
          accuracy: 0,
          altitude: 0,
          altitudeAccuracy: 0,
          timestamp: DateTime.now().toUtc(),
          locationSource: LocationSource.gps,
        );
        _mapController.move(_userLocation!, 16);
      } else {
        _selectedLocation = null;
      }
    });

    context.read<LocationBloc>().add(LocationTrackingStarted());
  }

  void _onMapLongPress(TapPosition tapPosition, LatLng point) {
    setState(() {
      _selectedLocation = GeoPosition(
        latitude: point.latitude,
        longitude: point.longitude,
        accuracy: 0,
        altitude: 0,
        altitudeAccuracy: 0,
        timestamp: DateTime.now().toUtc(),
        locationSource: LocationSource.manual,
      );
    });
  }

  void _onConfirm() {
    if (_selectedLocation == null) return;
    context.pop(
      _selectedLocation,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    final selectedLatLng = _selectedLocation != null
        ? LatLng(_selectedLocation!.latitude, _selectedLocation!.longitude)
        : null;

    return BlocListener<LocationBloc, LocationState>(
      listener: (context, state) {
        if (state is LocationLoadSuccess) {
          final point = LatLng(
            state.position.latitude,
            state.position.longitude,
          );

          setState(() {
            _userLocation = point;

            if (!_isManual) {
              _selectedLocation = state.position;
              _mapController.move(point, 16);
            }
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
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: false,
          title: Text(l10n.mapPickerTitle),
          backgroundColor: theme.colorScheme.surface.withValues(alpha: 0.8),
          elevation: 0,
        ),
        body: BlocBuilder<LocationBloc, LocationState>(
          builder: (context, state) {
            final isLoading = state is LocationLoadInProgress && !_isManual;

            return Stack(
              children: [
                AbsorbPointer(
                  absorbing: isLoading,
                  child: AppMapView(
                    mapController: _mapController,
                    initialCenter: selectedLatLng ?? _userLocation,
                    initialZoom: selectedLatLng != null ? 16.0 : 8.0,
                    userLocation: _userLocation,
                    onLongPress: _onMapLongPress,
                    onHelp: () {
                      final l10n = AppLocalizations.of(context)!;
                      unawaited(
                        AppSheet.showInfo(
                          context: context,
                          title: l10n.mapPickerHelpTitle,
                          message: l10n.mapPickerHelpContent,
                          buttonText: l10n.understood,
                        ),
                      );
                    },
                    markers: [
                      if (selectedLatLng != null)
                        Marker(
                          point: selectedLatLng,
                          width: AppDimensions.xxl,
                          height: AppDimensions.xxl,
                          rotate: true,
                          alignment: Alignment.topCenter,
                          child: Icon(
                            Icons.location_on,
                            color: Colors.redAccent,
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
                    ],
                    bottomAction: Align(
                      alignment: Alignment.bottomCenter,
                      child: SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            bottom: AppDimensions.xxl,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AppButtonFab.small(
                                heroTag: 'reset_to_gps',
                                icon: Icons.my_location,
                                isDisabled: !_isManual,
                                style: _isManual
                                    ? AppButtonFabStyle.secondary
                                    : AppButtonFabStyle.surface,
                                onPressed: _resetToGps,
                              ),
                              const SizedBox(width: AppDimensions.md),

                              AppButtonFab.extended(
                                heroTag: 'map_picker_confirm_btn',
                                onPressed: _selectedLocation == null
                                    ? null
                                    : _onConfirm,
                                icon: Icons.check_circle,
                                label: l10n.mapPickerConfirm,
                                style: _selectedLocation == null
                                    ? AppButtonFabStyle.surface
                                    : AppButtonFabStyle.primary,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                if (isLoading)
                  Positioned.fill(
                    child: LoadingOverlay(message: l10n.locationWaitingGps),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
