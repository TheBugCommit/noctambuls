import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class ListeningPointField extends StatelessWidget {
  const ListeningPointField({
    required this.controller,
    required this.isReadOnly,
    required this.hasError,
    required this.onChanged,
    super.key,
  });

  final TextEditingController controller;
  final bool isReadOnly;
  final bool hasError;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.listeningPointLabel,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: hasError ? colorScheme.error : null,
          ),
        ),
        const SizedBox(height: AppDimensions.sm),
        TextField(
          controller: controller,
          readOnly: isReadOnly,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: l10n.listeningPointHint,
            errorText: hasError ? l10n.reviewRequiredFieldError : null,
            border: const OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: hasError
                    ? colorScheme.error
                    : colorScheme.outlineVariant,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: hasError ? colorScheme.error : colorScheme.primary,
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
