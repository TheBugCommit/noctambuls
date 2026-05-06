import 'package:flutter/material.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/presentation/widgets/time_text.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';

class ReviewHeader extends StatelessWidget {
  const ReviewHeader({required this.session, super.key});

  final ObservationSession session;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final timeStyle = theme.textTheme.titleMedium?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        if (session.startTime != null && session.endTime != null) ...[
          TimeText.dateTime(
            session.startTime,
            formatStyle: DateTimeFormatStyle.dateLong,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: AppDimensions.md),

          TimeText.dateTime(
            session.startTime,
            formatStyle: DateTimeFormatStyle.timeOnly,
            style: timeStyle,
          ),

          Text(' – ', style: timeStyle),

          TimeText.dateTime(
            session.endTime,
            formatStyle: DateTimeFormatStyle.timeOnly,
            style: timeStyle,
          ),
        ],
      ],
    );
  }
}
