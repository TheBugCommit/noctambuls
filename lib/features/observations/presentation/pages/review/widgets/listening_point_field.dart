import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:noctambuls/core/presentation/utils/numerical_range_formatter.dart';
import 'package:noctambuls/core/presentation/widgets/app_text_field.dart';
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

    return AppTextField(
      controller: controller,
      label: l10n.listeningPointLabel,
      hintText: l10n.listeningPointHint,
      enabled: !isReadOnly,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        NumericalRangeFormatter(min: 1, max: 500),
      ],
      errorText: hasError ? l10n.reviewRequiredFieldError : null,
      onFocusLost: onChanged,
    );
  }
}
