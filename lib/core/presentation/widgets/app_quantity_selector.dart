import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class AppQuantitySelector extends StatefulWidget {
  const AppQuantitySelector({
    required this.controller,
    required this.label,
    this.minValue = 1,
    this.maxValue = 20,
    this.enabled = true,
    super.key,
  });

  final TextEditingController controller;
  final String label;
  final int minValue;
  final int maxValue;
  final bool enabled;

  @override
  State<AppQuantitySelector> createState() => _AppQuantitySelectorState();
}

class _AppQuantitySelectorState extends State<AppQuantitySelector> {
  void _increment() {
    final currentValue =
        int.tryParse(widget.controller.text) ?? widget.minValue;
    if (currentValue < widget.maxValue) {
      widget.controller.text = (currentValue + 1).toString();
    }
  }

  void _decrement() {
    final currentValue =
        int.tryParse(widget.controller.text) ?? widget.minValue;
    if (currentValue > widget.minValue) {
      widget.controller.text = (currentValue - 1).toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: theme.textTheme.titleSmall?.copyWith(
            color: widget.enabled ? null : colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppDimensions.xs),

        Opacity(
          opacity: widget.enabled ? 1.0 : 0.6,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.sm,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
              border: Border.all(
                color: colorScheme.outlineVariant.withValues(alpha: 0.5),
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: widget.enabled ? _decrement : null,
                  icon: const Icon(Icons.remove),
                  color: colorScheme.primary,
                  tooltip: l10n.reduceQuantityTooltip,
                ),

                Expanded(
                  child: TextFormField(
                    controller: widget.controller,
                    enabled: widget.enabled,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                    onChanged: (value) {
                      final intValue = int.tryParse(value);
                      if (intValue != null) {
                        if (intValue < widget.minValue) {
                          widget.controller.text = widget.minValue.toString();
                          widget.controller.selection = TextSelection.collapsed(
                            offset: widget.controller.text.length,
                          );
                        } else if (intValue > widget.maxValue) {
                          widget.controller.text = widget.maxValue.toString();
                          widget.controller.selection = TextSelection.collapsed(
                            offset: widget.controller.text.length,
                          );
                        }
                      }
                    },
                  ),
                ),

                IconButton(
                  onPressed: widget.enabled ? _increment : null,
                  icon: const Icon(Icons.add),
                  color: colorScheme.primary,
                  tooltip: l10n.incrementQuantityTooltip,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
