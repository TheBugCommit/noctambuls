import 'package:flutter/material.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/features/explore/domain/entities/map_bubble.dart';
import 'package:noctambuls/features/guide/domain/entities/bird.dart';

class SpeciesBreakdown extends StatelessWidget {
  const SpeciesBreakdown({
    required this.filteredBubbles,
    required this.speciesNames,
    super.key,
  });

  final List<MapBubble> filteredBubbles;
  final Map<String, Bird> speciesNames;

  @override
  Widget build(BuildContext context) {
    final aggregated = <String, int>{};
    for (final b in filteredBubbles) {
      aggregated[b.speciesId] = (aggregated[b.speciesId] ?? 0) + b.count;
    }

    if (aggregated.isEmpty) return const SizedBox.shrink();

    final sorted = aggregated.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final maxCount = sorted.first.value;

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: sorted.length,
      separatorBuilder: (context, index) =>
          const SizedBox(height: AppDimensions.md),
      itemBuilder: (context, index) {
        final entry = sorted[index];
        final bird = speciesNames[entry.key];

        return _SpeciesRow(
          commonName: bird?.commonName ?? entry.key,
          scientificName: bird?.scientificName,
          count: entry.value,
          maxCount: maxCount,
        );
      },
    );
  }
}

class _SpeciesRow extends StatelessWidget {
  const _SpeciesRow({
    required this.commonName,
    required this.scientificName,
    required this.count,
    required this.maxCount,
  });

  final String commonName;
  final String? scientificName;
  final int count;
  final int maxCount;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final fraction = maxCount > 0 ? count / maxCount : 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    commonName,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (scientificName != null)
                    Text(
                      scientificName!,
                      style: textTheme.bodyMedium?.copyWith(
                        fontStyle: FontStyle.italic,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
            const SizedBox(width: AppDimensions.sm),
            Text(
              count.toString(),
              style: textTheme.titleMedium?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.sm),

        LinearProgressIndicator(
          value: fraction,
          minHeight: AppDimensions.sm,
          backgroundColor: colorScheme.surfaceContainerHighest,
          color: colorScheme.primary,
          borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
        ),
      ],
    );
  }
}
