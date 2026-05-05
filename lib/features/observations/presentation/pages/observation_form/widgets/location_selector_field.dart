import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/presentation/widgets/app_button.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class LocationSelectorField extends StatefulWidget {
  const LocationSelectorField({
    required this.latitude,
    required this.longitude,
    required this.onLocationChanged,
    super.key,
  });

  final double? latitude;
  final double? longitude;
  final void Function(double lat, double lng) onLocationChanged;

  @override
  State<LocationSelectorField> createState() => _LocationSelectorFieldState();
}

class _LocationSelectorFieldState extends State<LocationSelectorField> {
  bool _isLoading = false;
  String? _errorMessage;

  // Afegim el FormFieldState com a paràmetre per poder-lo actualitzar
  Future<void> _fetchLocation(FormFieldState<bool> formFieldState) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('El servei de localització està desactivat.');
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Missatge clar si es denega
          throw Exception(
            'Sense permís de localització no es pot registrar l\'observació.',
          );
        }
      }
      if (permission == LocationPermission.deniedForever) {
        throw Exception(
          'Permisos denegats permanentment. Activa\'ls als ajustos de l\'app.',
        );
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      widget.onLocationChanged(position.latitude, position.longitude);

      // MARQUEM EL CAMP COM A VÀLID AL FORMULARI
      formFieldState.didChange(true);
    } catch (e) {
      setState(() => _errorMessage = e.toString());
      formFieldState.didChange(
        null,
      ); // Si falla, el tornem a marcar com a invàlid
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final hasLocation = widget.latitude != null && widget.longitude != null;

    // LA MÀGIA: FormField per integrar-se al _formKey de la pàgina principal
    return FormField<bool>(
      initialValue: hasLocation,
      validator: (value) {
        if (value != true) {
          return 'La ubicació GPS és obligatòria.';
        }
        return null;
      },
      builder: (formFieldState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${l10n.locationLabel} *',
              style: theme.textTheme.titleSmall,
            ),
            const SizedBox(height: AppDimensions.xs),

            if (!hasLocation) ...[
              SizedBox(
                width: double.infinity,
                child: AppButton(
                  onPressed: _isLoading
                      ? null
                      : () => _fetchLocation(formFieldState),
                  icon: Icons.my_location,
                  label: _isLoading
                      ? 'Obtenint GPS...'
                      : 'Capturar ubicació actual',
                  style: AppButtonStyle.secondary,
                ),
              ),
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: AppDimensions.xs),
                  child: Text(
                    _errorMessage!,
                    style: TextStyle(
                      color: theme.colorScheme.error,
                      fontSize: 12,
                    ),
                  ),
                ),
            ] else ...[
              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
                  border: Border.all(
                    // Si per algun motiu el form falla, pintem la vora del mapa de vermell
                    color: formFieldState.hasError
                        ? theme.colorScheme.error
                        : theme.colorScheme.outlineVariant,
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    FlutterMap(
                      options: MapOptions(
                        initialCenter: LatLng(
                          widget.latitude!,
                          widget.longitude!,
                        ),
                        initialZoom: 15.0,
                        interactionOptions: const InteractionOptions(
                          flags: InteractiveFlag.none,
                        ),
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName:
                              'com.associaciotaxus.noctambuls',
                        ),
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: LatLng(
                                widget.latitude!,
                                widget.longitude!,
                              ),
                              width: 40,
                              height: 40,
                              child: const Icon(
                                Icons.location_on,
                                color: Colors.red,
                                size: 40,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(AppDimensions.sm),
                        color: Colors.black.withOpacity(0.7),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.satellite_alt,
                                  color: Colors.greenAccent,
                                  size: 16,
                                ),
                                const SizedBox(width: AppDimensions.xs),
                                Text(
                                  'GPS Fixat',
                                  style: theme.textTheme.labelMedium?.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '${widget.latitude!.toStringAsFixed(5)}, ${widget.longitude!.toStringAsFixed(5)}',
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: Colors.white70,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: AppDimensions.sm,
                      right: AppDimensions.sm,
                      child: IconButton.filled(
                        onPressed: _isLoading
                            ? null
                            : () => _fetchLocation(formFieldState),
                        icon: _isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Icon(Icons.refresh, size: 20),
                        style: IconButton.styleFrom(
                          backgroundColor: theme.colorScheme.primary
                              .withOpacity(0.9),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            // Missatge d'error vermell si es clica "Desar" sense tenir GPS
            if (formFieldState.hasError)
              Padding(
                padding: const EdgeInsets.only(top: AppDimensions.xs),
                child: Text(
                  formFieldState.errorText!,
                  style: TextStyle(
                    color: theme.colorScheme.error,
                    fontSize: theme.textTheme.labelMedium?.fontSize,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
