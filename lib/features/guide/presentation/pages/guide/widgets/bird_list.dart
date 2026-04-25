import 'package:flutter/material.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/features/guide/domain/entities/bird.dart';
import 'package:noctambuls/features/guide/presentation/pages/guide/widgets/bird_card.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class BirdList extends StatelessWidget {
  const BirdList({required this.birds, super.key});

  final List<Bird> birds;

  @override
  Widget build(BuildContext context) {
    if (birds.isEmpty) {
      return const _GuideEmptyView();
    }

    return ListView.separated(
      padding: const EdgeInsets.all(AppDimensions.md),
      itemCount: birds.length,
      separatorBuilder: (_, _) => const SizedBox(height: AppDimensions.sm),
      itemBuilder: (context, index) => BirdCard(bird: birds[index]),
    );
  }
}

class _GuideEmptyView extends StatelessWidget {
  const _GuideEmptyView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Center(
      child: Text(l10n.noBirdsFound),
    );
  }
}
