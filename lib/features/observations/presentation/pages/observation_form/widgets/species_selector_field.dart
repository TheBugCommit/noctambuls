import 'package:flutter/material.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/presentation/widgets/app_dropdown.dart';
import 'package:noctambuls/features/guide/domain/entities/bird.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class SpeciesSelectorField extends StatelessWidget {
  const SpeciesSelectorField({
    required this.birds,
    required this.selectedSpeciesId,
    required this.onChanged,
    super.key,
  });

  final List<Bird> birds;
  final String? selectedSpeciesId;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.selectSpecies,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: AppDimensions.xs),
        AppDropdown<String>(
          value: selectedSpeciesId,
          items: birds.map((bird) {
            return DropdownMenuItem(
              value: bird.id,
              child: Text(bird.commonName),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
