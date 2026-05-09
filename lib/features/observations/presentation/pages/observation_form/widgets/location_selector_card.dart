import 'package:flutter/material.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/domain/entities/geo_position.dart';
import 'package:noctambuls/core/domain/enums/location_source.dart';
import 'package:noctambuls/core/presentation/widgets/app_button.dart';
import 'package:noctambuls/features/observations/domain/enums/location_error_type.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class LocationSelectorCard extends StatelessWidget {
  const LocationSelectorCard({
    required this.isAtLocation,
    required this.onToggleChange,
    required this.onOpenMap,
    this.location,
    this.locationError,
    this.isLoading = false,
    this.isReadOnly = false,
    super.key,
  });

  final bool isAtLocation;
  final ValueChanged<bool> onToggleChange;
  final VoidCallback onOpenMap;
  final GeoPosition? location;
  final LocationErrorType? locationError;
  final bool isReadOnly;
  final bool isLoading;

  String _getErrorMessage(AppLocalizations l10n, LocationErrorType error) {
    return switch (error) {
      LocationErrorType.permissionDenied => l10n.locationErrorPermission,
      LocationErrorType.gpsDisabled => l10n.locationErrorDisabled,
      LocationErrorType.timeoutNoSignal => l10n.locationErrorTimeout,
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    // Variables derivades de l'estat i l'entitat de domini
    final isManual = location?.locationSource == LocationSource.manual;
    final hasCoordinates = location != null;
    final hasError = isAtLocation && locationError != null && !isLoading;
    final fgColor = (hasCoordinates && !isLoading)
        ? isManual
              ? theme.colorScheme.tertiary
              : theme.colorScheme.primary
        : theme.colorScheme.onSurfaceVariant;
    final bgColor = hasCoordinates
        ? isManual
              ? theme.colorScheme.tertiaryContainer.withValues(alpha: 0.3)
              : theme.colorScheme.primaryContainer.withValues(alpha: 0.3)
        : theme.colorScheme.surfaceContainerHighest;
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border.all(
          color: hasError
              ? theme.colorScheme.error
              : theme.colorScheme.outlineVariant,
        ),
        borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
      ),
      padding: const EdgeInsets.all(AppDimensions.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: AppDimensions.sm),
              Text(
                l10n.observationLocationTitle,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.md),

          if (!isReadOnly) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    l10n.observationAtLocationToggle,
                    style: theme.textTheme.bodyLarge,
                  ),
                ),
                Switch.adaptive(
                  value: isAtLocation,
                  onChanged: onToggleChange,
                  activeTrackColor: theme.colorScheme.primary,
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.sm),
          ],

          if (hasError)
            Padding(
              padding: const EdgeInsets.only(bottom: AppDimensions.sm),
              child: Text(
                _getErrorMessage(l10n, locationError!),
                style: TextStyle(color: theme.colorScheme.error, fontSize: 12),
              ),
            ),

          Container(
            padding: const EdgeInsets.all(AppDimensions.sm),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
            ),
            child: Row(
              children: [
                Icon(
                  isLoading
                      ? Icons.satellite_alt_outlined
                      : hasCoordinates
                      ? (isManual ? Icons.location_pin : Icons.check_circle)
                      : Icons.satellite_alt_outlined,
                  color: fgColor,
                ),
                const SizedBox(width: AppDimensions.sm),
                Expanded(
                  child: Text(
                    isLoading
                        ? l10n.locationWaitingGps
                        : hasCoordinates
                        ? (isManual
                              ? '${l10n.locationManualTitle} ${location!.latitude.toStringAsFixed(5)}, ${location!.longitude.toStringAsFixed(5)}'
                              : '${location!.latitude.toStringAsFixed(5)}, ${location!.longitude.toStringAsFixed(5)}')
                        : (isAtLocation
                              ? l10n.locationWaitingGps
                              : l10n.locationMapRequired),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: fgColor,
                      fontWeight: (hasCoordinates && !isLoading)
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),

          if ((!isAtLocation || hasError) && !isReadOnly)
            Padding(
              padding: const EdgeInsets.only(top: AppDimensions.md),
              child: SizedBox(
                width: double.infinity,
                child: AppButton.secondary(
                  onPressed: onOpenMap,
                  icon: Icons.map_outlined,
                  label: hasCoordinates
                      ? l10n.locationModifyMap
                      : l10n.locationOpenMap,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
