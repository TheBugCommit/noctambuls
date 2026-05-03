import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/presentation/bloc/url/url_bloc.dart';
import 'package:noctambuls/core/presentation/bloc/url/url_event.dart';
import 'package:noctambuls/core/presentation/widgets/app_button.dart';
import 'package:noctambuls/features/guide/domain/entities/bird.dart';
import 'package:noctambuls/features/guide/presentation/pages/guide/widgets/bird_audio_button.dart';
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
    final l10n = AppLocalizations.of(context)!;

    return AspectRatio(
      aspectRatio: 4 / 3,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: _buildImage(context, l10n),
      ),
    );
  }

  Widget _buildImage(BuildContext context, AppLocalizations l10n) {
    if (bird.hasLocalImage) {
      return _buildLocalImage(context, l10n);
    } else if (bird.imageUrl.isNotEmpty) {
      return _buildNetworkImage(context, l10n);
    } else {
      return _errorBuilder(context, l10n.noImageAvailable, null);
    }
  }

  Widget _buildLocalImage(BuildContext context, AppLocalizations l10n) {
    return Image.file(
      File(bird.localImagePath!),
      fit: BoxFit.cover,
      alignment: Alignment.topCenter,
      semanticLabel: l10n.semanticLabelBirdImage(bird.commonName),
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) return child;
        return AnimatedOpacity(
          opacity: frame == null ? 0 : 1,
          duration: const Duration(milliseconds: 300),
          child: child,
        );
      },
      errorBuilder: _errorBuilder,
    );
  }

  Widget _buildNetworkImage(BuildContext context, AppLocalizations l10n) {
    return Image.network(
      bird.imageUrl,
      fit: BoxFit.cover,
      alignment: Alignment.topCenter,
      semanticLabel: l10n.semanticLabelBirdImage(bird.commonName),
      cacheWidth: 800,

      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return _placeholder(context);
      },

      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) return child;
        return AnimatedOpacity(
          opacity: frame == null ? 0 : 1,
          duration: const Duration(milliseconds: 300),
          child: child,
        );
      },

      errorBuilder: _errorBuilder,
    );
  }

  Widget _placeholder(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: const Center(
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
    );
  }

  Widget _errorBuilder(
    BuildContext context,
    Object error,
    StackTrace? stackTrace,
  ) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: const Center(
        child: Icon(
          Icons.image_not_supported_outlined,
          size: AppDimensions.xxl,
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
