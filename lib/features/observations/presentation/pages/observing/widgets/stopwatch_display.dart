import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/features/observations/presentation/cubit/stopwatch_cubit.dart';
import 'package:noctambuls/features/observations/presentation/pages/observing/widgets/time_text.dart';

class StopwatchDisplay extends StatelessWidget {
  const StopwatchDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final elapsed = context.select((StopwatchCubit cubit) => cubit.state);
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.timer_outlined,
          size: AppDimensions.iconXs,
          color: theme.colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: AppDimensions.xs),
        TimeText(duration: elapsed, withSeconds: true),
      ],
    );
  }
}
