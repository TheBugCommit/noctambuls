import 'package:flutter/material.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/features/censuses/domain/entities/census.dart';
import 'package:noctambuls/features/censuses/presentation/widgets/census_card.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class UpcomingCensusesSection extends StatelessWidget {
  const UpcomingCensusesSection({
    required this.censuses,
    required this.onCensusTap,
    super.key,
  });

  final List<Census> censuses;
  final void Function(Census) onCensusTap;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final upcoming =
        censuses
            .where(
              (c) =>
                  !c.alreadyDone &&
                  c.startTime.isAfter(
                    now.subtract(const Duration(hours: 6)),
                  ),
            )
            .toList()
          ..sort((a, b) => a.startTime.compareTo(b.startTime));

    if (upcoming.isEmpty) return const SizedBox.shrink();

    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: upcoming.length,
          separatorBuilder: (_, _) => const SizedBox(height: AppDimensions.sm),
          itemBuilder: (context, index) {
            final census = upcoming[index];
            return CensusCard(
              census: census,
              onTap: () => onCensusTap(census),
            );
          },
        ),
      ],
    );
  }
}
