import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum DateTimeFormatStyle {
  timeOnly, // 14:30
  timeWithSeconds, // 14:30:45
  dateOnly, // 15/10/2023 (o 10/15/2023 als EUA)
  dateAndTime, // 15/10/2023 • 14:30
}

class TimeText extends StatelessWidget {
  const TimeText.duration(
    this.duration, {
    this.withSeconds = false,
    this.prefixText,
    this.style,
    super.key,
  }) : dateTime = null,
       formatStyle = null;

  const TimeText.dateTime(
    this.dateTime, {
    this.formatStyle = DateTimeFormatStyle.dateAndTime,
    this.prefixText,
    this.style,
    super.key,
  }) : duration = null,
       withSeconds = false;

  final Duration? duration;
  final DateTime? dateTime;
  final bool withSeconds;
  final DateTimeFormatStyle? formatStyle;
  final String? prefixText;
  final TextStyle? style;

  String _formatDuration(Duration d) {
    final h = d.inHours;
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');

    if (h > 0) {
      return withSeconds ? '$h:$m:$s' : '$h:$m h';
    } else {
      return withSeconds ? '$m:$s' : '$m min';
    }
  }

  String _formatDateTime(BuildContext context, DateTime dt) {
    final locale = Localizations.localeOf(context).languageCode;

    switch (formatStyle!) {
      case DateTimeFormatStyle.timeOnly:
        return DateFormat.Hm(locale).format(dt); // 14:30

      case DateTimeFormatStyle.timeWithSeconds:
        return DateFormat.Hms(locale).format(dt); // 14:30:45

      case DateTimeFormatStyle.dateOnly:
        return DateFormat.yMd(locale).format(dt); // 15/10/2023

      case DateTimeFormatStyle.dateAndTime:
        final dateStr = DateFormat.yMd(locale).format(dt);
        final timeStr = DateFormat.Hm(locale).format(dt);
        return '$dateStr • $timeStr';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final timeString = duration != null
        ? _formatDuration(duration!)
        : _formatDateTime(context, dateTime!);

    final finalText = prefixText != null
        ? '$prefixText$timeString'
        : timeString;

    return Text(
      finalText,
      style:
          style ??
          theme.textTheme.labelMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
    );
  }
}
