import 'dart:io';

import 'package:flutter/material.dart';
import 'package:noctambuls/features/guide/domain/entities/bird.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class BirdImage extends StatelessWidget {
  const BirdImage({
    required this.bird,
    this.fit = BoxFit.cover,
    this.cacheWidth,
    super.key,
  });

  final Bird bird;
  final BoxFit fit;
  final int? cacheWidth;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

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
      fit: fit,
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
      fit: fit,
      alignment: Alignment.topCenter,
      semanticLabel: l10n.semanticLabelBirdImage(bird.commonName),
      cacheWidth: cacheWidth,
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
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
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
      child: Center(
        child: Icon(
          Icons.image_not_supported_outlined,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
