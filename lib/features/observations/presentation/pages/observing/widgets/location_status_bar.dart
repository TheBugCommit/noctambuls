import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/domain/enums/location_source.dart';
import 'package:noctambuls/core/presentation/bloc/location/location_bloc.dart';
import 'package:noctambuls/core/presentation/bloc/location/location_state.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/presentation/shared_widgets/animated_pulsed_location.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class LocationStatusBar extends StatelessWidget {
  const LocationStatusBar({
    required this.session,
    required this.onPressed,
    super.key,
  });

  final ObservationSession session;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    final location = session.location;
    final isManual = location?.locationSource == LocationSource.manual;
    final locState = context.watch<LocationBloc>().state;
    final isGpsFailing = locState is LocationLoadFailure && !isManual;
    final hasError = session.locationError != null || isGpsFailing;

    var statusText = l10n.locationWaitingGps;
    var barColor = theme.colorScheme.secondaryContainer.withValues(
      alpha: 0.7,
    );

    if (hasError) {
      statusText = l10n.locationErrorTimeout;
      barColor = theme.colorScheme.errorContainer.withValues(alpha: 0.7);
    } else if (location != null) {
      if (isManual) {
        statusText = l10n.locationManualTitle;
        barColor = theme.colorScheme.tertiaryContainer.withValues(alpha: 0.5);
      } else {
        statusText = l10n.locationAutoTitle;
      }
    }

    return Material(
      color: barColor,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.md,
            vertical: AppDimensions.sm,
          ),
          child: Row(
            children: [
              AnimatedPulseLocation(
                session: session,
                onPressed: onPressed,
              ),
              const SizedBox(width: AppDimensions.md),
              Expanded(
                child: Text(
                  statusText,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: hasError ? theme.colorScheme.error : null,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right,
                size: AppDimensions.iconSm,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
