import 'package:flutter/material.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';

class MeteoOption<T> {
  const MeteoOption({required this.value, required this.label});

  final T value;
  final String label;
}

class MeteoChoiceGroup<T> extends StatelessWidget {
  const MeteoChoiceGroup({
    required this.title,
    required this.options,
    required this.selectedValue,
    required this.isReadOnly,
    this.onChanged,
    super.key,
  });

  final String title;
  final List<MeteoOption<T>> options;
  final T selectedValue;
  final bool isReadOnly;
  final ValueChanged<T>? onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppDimensions.sm),
          Wrap(
            spacing: AppDimensions.sm,
            runSpacing: AppDimensions.sm,
            children: options.map((option) {
              final isSelected = selectedValue == option.value;

              return FilterChip(
                label: Text(option.label),
                selected: isSelected,
                showCheckmark: true,
                onSelected: isReadOnly ? null : (_) => onChanged?.call(option.value),
                backgroundColor: Colors.transparent,
                selectedColor: colorScheme.primary.withValues(alpha: 0.2),
                checkmarkColor: colorScheme.primary,
                labelStyle: TextStyle(
                  color: isSelected ? colorScheme.primary : colorScheme.onSurface,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
                  side: BorderSide(
                    color: isSelected
                        ? colorScheme.primary
                        : colorScheme.outlineVariant,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
