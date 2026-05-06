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
    final theme = Theme.of(context);

    return FormField<String>(
      initialValue: selectedSpeciesId,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return l10n.requiredFieldError;
        }
        return null;
      },
      builder: (formFieldState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.selectSpecies,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: AppDimensions.xs),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
                border: Border.all(
                  color: formFieldState.hasError
                      ? theme.colorScheme.error
                      : Colors.transparent,
                  width: 1.5,
                ),
              ),
              child: AppDropdown<String>(
                value: selectedSpeciesId,
                items: birds.map((bird) {
                  return DropdownMenuItem(
                    value: bird.id,
                    child: Text(bird.commonName),
                  );
                }).toList(),
                onChanged: (value) {
                  onChanged(value);
                  formFieldState.didChange(value);
                },
              ),
            ),
            SizedBox(
              height: AppDimensions.lg,
              child: formFieldState.hasError
                  ? Padding(
                      padding: const EdgeInsets.only(
                        top: AppDimensions.xs,
                        left: AppDimensions.sm,
                      ),
                      child: Text(
                        formFieldState.errorText!,
                        style: TextStyle(
                          color: theme.colorScheme.error,
                          fontSize: theme.textTheme.labelMedium?.fontSize,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        );
      },
    );
  }
}
