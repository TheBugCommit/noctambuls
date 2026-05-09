import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_record.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/enums/moon_presence.dart';
import 'package:noctambuls/features/observations/domain/enums/rain_level.dart';
import 'package:noctambuls/features/observations/domain/enums/sky_condition.dart';
import 'package:noctambuls/features/observations/domain/enums/temperature_range.dart';
import 'package:noctambuls/features/observations/domain/enums/visibility_level.dart';
import 'package:noctambuls/features/observations/domain/enums/wind_level.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_observation_bloc.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_observation_state.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_review_bloc.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_review_event.dart';
import 'package:noctambuls/features/observations/presentation/pages/review/widgets/meteo_choice_group.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class ReviewMeteoSection extends StatelessWidget {
  const ReviewMeteoSection({
    required this.session,
    required this.isReadOnly,
    super.key,
  });

  final ObservationSession session;
  final bool isReadOnly;

  List<ObservationRecord> _getObs(BuildContext context) {
    final st = context.read<SessionObservationBloc>().state;
    return st is ObservationsLoaded ? st.observations : [];
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.reviewMeteoTitle,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppDimensions.md),
        MeteoChoiceGroup<TemperatureRange>(
          title: l10n.meteoTemp,
          isReadOnly: isReadOnly,
          selectedValue: session.temperature,
          onChanged: (val) => context.read<SessionReviewBloc>().add(
            ReviewUpdateProperties(
              temperature: val,
              observations: _getObs(context),
            ),
          ),
          options: [
            MeteoOption(
              value: TemperatureRange.belowZero,
              label: l10n.meteoTempBelow0,
            ),
            MeteoOption(
              value: TemperatureRange.zeroToTen,
              label: l10n.meteoTemp0to10,
            ),
            MeteoOption(
              value: TemperatureRange.tenToTwenty,
              label: l10n.meteoTemp10to20,
            ),
            MeteoOption(
              value: TemperatureRange.twentyToThirty,
              label: l10n.meteoTemp20to30,
            ),
            MeteoOption(
              value: TemperatureRange.aboveThirty,
              label: l10n.meteoTempAbove30,
            ),
          ],
        ),
        MeteoChoiceGroup<WindLevel>(
          title: l10n.meteoWind,
          isReadOnly: isReadOnly,
          selectedValue: session.wind,
          onChanged: (val) => context.read<SessionReviewBloc>().add(
            ReviewUpdateProperties(wind: val, observations: _getObs(context)),
          ),
          options: [
            MeteoOption(value: WindLevel.calm, label: l10n.meteoWindCalm),
            MeteoOption(value: WindLevel.breeze, label: l10n.meteoWindBreeze),
            MeteoOption(
              value: WindLevel.moderate,
              label: l10n.meteoWindModerate,
            ),
          ],
        ),
        MeteoChoiceGroup<SkyCondition>(
          title: l10n.meteoSky,
          isReadOnly: isReadOnly,
          selectedValue: session.sky,
          onChanged: (val) => context.read<SessionReviewBloc>().add(
            ReviewUpdateProperties(sky: val, observations: _getObs(context)),
          ),
          options: [
            MeteoOption(value: SkyCondition.clear, label: l10n.meteoSkyClear),
            MeteoOption(
              value: SkyCondition.partialCloudy,
              label: l10n.meteoSkyPartlyCloudy,
            ),
            MeteoOption(
              value: SkyCondition.overcast,
              label: l10n.meteoSkyOvercast,
            ),
          ],
        ),
        MeteoChoiceGroup<RainLevel>(
          title: l10n.meteoRain,
          isReadOnly: isReadOnly,
          selectedValue: session.rain,
          onChanged: (val) => context.read<SessionReviewBloc>().add(
            ReviewUpdateProperties(rain: val, observations: _getObs(context)),
          ),
          options: [
            MeteoOption(value: RainLevel.none, label: l10n.meteoRainAbsence),
            MeteoOption(value: RainLevel.drizzle, label: l10n.meteoRainDrizzle),
            MeteoOption(value: RainLevel.storm, label: l10n.meteoRainStorm),
          ],
        ),
        MeteoChoiceGroup<VisibilityLevel>(
          title: l10n.meteoVisibility,
          isReadOnly: isReadOnly,
          selectedValue: session.visibility,
          onChanged: (val) => context.read<SessionReviewBloc>().add(
            ReviewUpdateProperties(
              visibility: val,
              observations: _getObs(context),
            ),
          ),
          options: [
            MeteoOption(
              value: VisibilityLevel.poor,
              label: l10n.meteoVisibilityPoor,
            ),
            MeteoOption(
              value: VisibilityLevel.moderate,
              label: l10n.meteoVisibilityFair,
            ),
            MeteoOption(
              value: VisibilityLevel.good,
              label: l10n.meteoVisibilityGood,
            ),
          ],
        ),
        MeteoChoiceGroup<MoonPresence>(
          title: l10n.meteoMoon,
          isReadOnly: isReadOnly,
          selectedValue: session.moon,
          onChanged: (val) => context.read<SessionReviewBloc>().add(
            ReviewUpdateProperties(moon: val, observations: _getObs(context)),
          ),
          options: [
            MeteoOption(
              value: MoonPresence.absent,
              label: l10n.meteoMoonAbsence,
            ),
            MeteoOption(
              value: MoonPresence.present,
              label: l10n.meteoMoonPresence,
            ),
          ],
        ),
      ],
    );
  }
}
