import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/core/presentation/bloc/audio/audio_bloc.dart';
import 'package:noctambuls/core/presentation/bloc/audio/audio_state.dart';
import 'package:noctambuls/core/presentation/widgets/app_button.dart';
import 'package:noctambuls/features/guide/presentation/bloc/guide_bloc.dart';
import 'package:noctambuls/features/guide/presentation/bloc/guide_event.dart';

class BirdAudioButton extends StatelessWidget {
  const BirdAudioButton({
    required this.audioPath,
    required this.labelPlay,
    required this.labelStop,
    super.key,
  });

  final String audioPath;
  final String labelPlay;
  final String labelStop;

  @override
  Widget build(BuildContext context) {
    if (audioPath.isEmpty) {
      return AppButton.outline(
        onPressed: null,
        icon: Icons.volume_up_outlined,
        label: labelPlay,
      );
    }

    return BlocSelector<AudioBloc, AudioState, String?>(
      selector: (state) => state.currentlyPlayingPath,
      builder: (context, currentlyPlayingPath) {
        final isPlaying = currentlyPlayingPath == audioPath;

        return AppButton.outline(
          onPressed: () => context.read<GuideBloc>().add(
            CheckBirdAudioWarningRequested(audioPath: audioPath),
          ),
          customIcon: isPlaying ? const _AudioWaveAnimation() : null,
          icon: isPlaying ? null : Icons.volume_up_outlined,
          label: isPlaying ? labelStop : labelPlay,
        );
      },
    );
  }
}

class _AudioWaveAnimation extends StatefulWidget {
  const _AudioWaveAnimation();

  @override
  State<_AudioWaveAnimation> createState() => _AudioWaveAnimationState();
}

class _AudioWaveAnimationState extends State<_AudioWaveAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    unawaited(_controller.repeat(reverse: true));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final offset = index * 0.3;
            final value = (_controller.value + offset) % 1.0;
            final height = 6.0 + (10.0 * (value > 0.5 ? 1.0 - value : value));

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 1.5),
              width: 3,
              height: height,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(2),
              ),
            );
          },
        );
      }),
    );
  }
}
