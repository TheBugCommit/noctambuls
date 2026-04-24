import 'package:flutter/material.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/widgets/app_button.dart';
import 'package:noctambuls/features/guide/domain/entities/bird.dart';
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
          BirdCardHeader(
            imagePath: bird.imagePath,
            birdName: bird.commonName,
          ),
          Padding(
            padding: const EdgeInsets.all(AppDimensions.lg),
            child: BirdCardContent(
              commonName: bird.commonName,
              scientificName: bird.scientificName,
              description: bird.description,
            ),
          ),

          // 3. Botons d'acció
          BirdCardActions(
            infoUrl: bird.infoUrl,
            audioPath: bird.audioPath,
          ),
        ],
      ),
    );
  }
}

class BirdCardHeader extends StatelessWidget {
  const BirdCardHeader({
    required this.imagePath,
    required this.birdName,
    super.key,
  });

  final String imagePath;
  final String birdName;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AspectRatio(
      aspectRatio: 4 / 3, //TODO: Revisar ajustament de les imatges
      child: Image.asset(
        imagePath,
        fit: BoxFit.cover,
        gaplessPlayback: true,
        alignment: Alignment.topCenter,
        semanticLabel: l10n.semanticLabelBirdImage(birdName),
        errorBuilder: (context, error, stackTrace) => ColoredBox(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          child: const Center(
            child: Icon(
              Icons.image_not_supported_outlined,
              size: AppDimensions.xxl,
            ),
          ),
        ),
      ),
    );
  }
}

class BirdCardContent extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          commonName,
          style: textTheme.headlineSmall,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: AppDimensions.xs),
        Text(
          scientificName,
          style: textTheme.bodySmall?.copyWith(
            fontStyle: FontStyle.italic,
            color: colorScheme.onSurfaceVariant,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: AppDimensions.sm),
        Text(
          description,
          style: textTheme.bodyMedium,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class BirdCardActions extends StatelessWidget {
  const BirdCardActions({
    required this.infoUrl,
    required this.audioPath,
    super.key,
  });

  final String infoUrl;
  final String audioPath;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.lg,
        vertical: AppDimensions.md,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppButton.outline(
            onPressed: () {
              // TODO: Integració player
            },
            icon: Icons.volume_up_outlined,
            label: l10n.listen,
          ),
          AppButton.primary(
            onPressed: () {
              // TODO: Integració url_launcher
            },
            icon: Icons.link,
            label: l10n.moreInfo,
          ),
        ],
      ),
    );
  }
}
