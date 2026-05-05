import 'package:flutter/material.dart';

class TimeText extends StatelessWidget {
  const TimeText({
    this.duration,
    this.dateTime,
    this.withSeconds = false,
    super.key,
  }) : assert(
         duration != null || dateTime != null,
         'Needed to pass duration or dateTime',
       );

  final Duration? duration;
  final DateTime? dateTime;
  final bool withSeconds;

  String _formatDuration(Duration d) {
    final h = d.inHours;
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');

    return h > 0 && withSeconds
        ? '${h.toString().padLeft(2, '0')}:$m:$s'
        : '$m:$s';
  }

  String _formatDateTime(DateTime dt) {
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    final s = dt.second.toString().padLeft(2, '0');

    return withSeconds ? '$h:$m:$s' : '$h:$m';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final text = duration != null
        ? _formatDuration(duration!)
        : _formatDateTime(dateTime!);

    return Text(
      text,
      style: theme.textTheme.labelMedium?.copyWith(
        color: theme.colorScheme.onSurfaceVariant,
      ),
    );
  }
}
