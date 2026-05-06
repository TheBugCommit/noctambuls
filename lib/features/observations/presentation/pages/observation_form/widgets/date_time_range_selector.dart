import 'package:flutter/material.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/presentation/widgets/time_text.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

/// Date header shown at the top of the observation form.
/// For incidental sessions the entire row is tappable to change the date.
class ObservationDateHeader extends StatelessWidget {
  const ObservationDateHeader({
    required this.session,
    required this.startTime,
    required this.endTime,
    required this.onChanged,
    this.onGlobalDateChanged,
    super.key,
  });

  final ObservationSession session;
  final DateTime startTime;
  final DateTime endTime;
  final void Function(DateTime start, DateTime end) onChanged;
  final void Function(DateTime)? onGlobalDateChanged;

  Future<void> _onDatePicked(BuildContext context) async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: startTime.isAfter(now) ? now : startTime,
      firstDate: DateTime(2020),
      lastDate: now,
    );
    if (pickedDate == null || !context.mounted) return;

    final currentNow = DateTime.now();
    var newStart = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      startTime.hour,
      startTime.minute,
    );
    var newEnd = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      endTime.hour,
      endTime.minute,
    );

    if (newStart.isAfter(currentNow)) newStart = currentNow;
    if (newEnd.isAfter(currentNow)) newEnd = currentNow;
    if (newStart.isAfter(newEnd)) newEnd = newStart;

    onChanged(newStart, newEnd);
    onGlobalDateChanged?.call(pickedDate);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final canEdit = session.canEditObservationDate;

    final dateStyle = theme.textTheme.headlineSmall?.copyWith(
      fontWeight: FontWeight.bold,
    );

    if (!canEdit) {
      return TimeText.dateTime(
        startTime,
        formatStyle: DateTimeFormatStyle.dateLong,
        style: dateStyle,
      );
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
        onTap: () => _onDatePicked(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppDimensions.xs),
          child: Row(
            children: [
              TimeText.dateTime(
                startTime,
                formatStyle: DateTimeFormatStyle.dateLong,
                style: dateStyle,
              ),
              const Spacer(),
              Icon(
                Icons.calendar_today_outlined,
                size: AppDimensions.iconMd,
                color: colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Time range selector (start + end time cards).
class DateTimeRangeSelectorField extends StatelessWidget {
  const DateTimeRangeSelectorField({
    required this.session,
    required this.startTime,
    required this.endTime,
    required this.onChanged,
    super.key,
  });

  final ObservationSession session;
  final DateTime startTime;
  final DateTime endTime;
  final void Function(DateTime start, DateTime end) onChanged;

  String _formatTime(DateTime dt) {
    final h = dt.hour.toString().padLeft(2, '0');
    final min = dt.minute.toString().padLeft(2, '0');
    return '$h:$min';
  }

  Future<void> _onStartTimePicked(BuildContext context) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(startTime),
    );
    if (pickedTime == null) return;

    final now = DateTime.now();
    final min = session.observationTimeMin;
    final max = session.observationTimeMax ?? now;

    var newStart = DateTime(
      startTime.year,
      startTime.month,
      startTime.day,
      pickedTime.hour,
      pickedTime.minute,
    );
    var newEnd = endTime;

    if (newStart.isAfter(max)) newStart = max;
    if (min != null && newStart.isBefore(min)) newStart = min;
    if (newStart.isAfter(newEnd)) newEnd = newStart;

    onChanged(newStart, newEnd);
  }

  Future<void> _onEndTimePicked(BuildContext context) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(endTime),
    );
    if (pickedTime == null) return;

    final now = DateTime.now();
    final min = session.observationTimeMin;
    final max = session.observationTimeMax ?? now;

    var newEnd = DateTime(
      endTime.year,
      endTime.month,
      endTime.day,
      pickedTime.hour,
      pickedTime.minute,
    );
    var newStart = startTime;

    if (newEnd.isAfter(max)) newEnd = max;
    if (min != null && newEnd.isBefore(min)) newEnd = min;
    if (newEnd.isBefore(newStart)) newStart = newEnd;

    onChanged(newStart, newEnd);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.timeRangeLabel, style: theme.textTheme.titleSmall),
        const SizedBox(height: AppDimensions.xs),
        Row(
          children: [
            Expanded(
              child: DateTimeSelectionCard(
                label: l10n.startTimeLabel,
                value: _formatTime(startTime),
                icon: Icons.access_time,
                onTap: () => _onStartTimePicked(context),
              ),
            ),
            const SizedBox(width: AppDimensions.md),
            Expanded(
              child: DateTimeSelectionCard(
                label: l10n.endTimeLabel,
                value: _formatTime(endTime),
                icon: Icons.access_time,
                onTap: () => _onEndTimePicked(context),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class DateTimeSelectionCard extends StatelessWidget {
  const DateTimeSelectionCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.onTap,
    super.key,
  });

  final String label;
  final String value;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.md,
            vertical: AppDimensions.sm,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: colorScheme.outlineVariant),
            borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
            color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: AppDimensions.xs / 2),
                    Text(
                      value,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: onTap != null
                            ? colorScheme.onSurface
                            : colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Icon(
                icon,
                size: AppDimensions.iconMd,
                color: onTap != null
                    ? colorScheme.primary
                    : colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
