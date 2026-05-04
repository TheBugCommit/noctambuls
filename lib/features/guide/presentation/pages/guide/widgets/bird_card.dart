import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/presentation/bloc/url/url_bloc.dart';
import 'package:noctambuls/core/presentation/bloc/url/url_event.dart';
import 'package:noctambuls/core/presentation/widgets/app_button.dart';
import 'package:noctambuls/features/guide/domain/entities/bird.dart';
import 'package:noctambuls/features/guide/presentation/pages/guide/widgets/bird_audio_button.dart';
import 'package:noctambuls/features/guide/presentation/pages/guide/widgets/bird_common_name.dart';
import 'package:noctambuls/features/guide/presentation/pages/guide/widgets/bird_image.dart';
import 'package:noctambuls/features/guide/presentation/pages/guide/widgets/bird_scientific_name.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class BirdCard extends StatelessWidget {
  const BirdCard({
    required this.bird,
    super.key,
  });

  final Bird bird;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BirdCardHeader(bird: bird),
          Padding(
            padding: const EdgeInsets.all(AppDimensions.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppDimensions.md,
              children: [
                BirdCardContent(
                  commonName: bird.commonName,
                  scientificName: bird.scientificName,
                  description: bird.description,
                ),
                BirdCardActions(bird: bird),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BirdCardHeader extends StatelessWidget {
  const BirdCardHeader({
    required this.bird,
    super.key,
  });

  final Bird bird;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BirdImage(
          bird: bird,
          cacheWidth: 800,
        ),
      ),
    );
  }
}

class BirdCardContent extends StatefulWidget {
  const BirdCardContent({
    required this.commonName,
    required this.scientificName,
    required this.description,
    super.key,
  });

  final String commonName;
  final String scientificName;
  final String description;

  @override
  State<BirdCardContent> createState() => _BirdCardContentState();
}

class _BirdCardContentState extends State<BirdCardContent> {
  bool _isExpanded = false;

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BirdCommonName(
          commonName: widget.commonName,
          style: textTheme.headlineSmall,
        ),
        const SizedBox(height: AppDimensions.xs),
        BirdScientificName(scientificName: widget.scientificName),
        const SizedBox(height: AppDimensions.sm),
        InkWell(
          onTap: _toggleExpanded,
          borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppDimensions.xs),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOutCubic,
                  alignment: Alignment.topCenter,
                  child: Text(
                    widget.description,
                    style: textTheme.bodyMedium,
                    maxLines: _isExpanded ? null : 4,
                    overflow: _isExpanded
                        ? TextOverflow.visible
                        : TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class BirdCardActions extends StatelessWidget {
  const BirdCardActions({
    required this.bird,
    super.key,
  });

  final Bird bird;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BirdAudioButton(
          audioPath: bird.hasLocalAudio ? bird.localAudioPath! : bird.audioUrl,
          labelPlay: l10n.listen,
          labelStop: l10n.stopPlayingAudio,
        ),
        AppButton.primary(
          onPressed: bird.infoUrl.isEmpty
              ? null
              : () => context.read<UrlBloc>().add(
                  OpenUrlRequested(bird.infoUrl),
                ),
          icon: Icons.link,
          label: l10n.moreInfo,
        ),
      ],
    );
  }
}
