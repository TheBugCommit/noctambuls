import 'package:flutter/material.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class ProfileFormFields extends StatelessWidget {
  const ProfileFormFields({
    required this.nameController,
    required this.phoneController,
    required this.isLoading,
    required this.onSubmit,
    super.key,
  });

  final TextEditingController nameController;
  final TextEditingController phoneController;
  final bool isLoading;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        TextFormField(
          controller: nameController,
          enabled: !isLoading,
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            labelText: l10n.signUpFormNameLabel,
            prefixIcon: const Icon(Icons.person_outline),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return l10n.signUpFormFieldRequired;
            }
            if (value.trim().length < 3) {
              return l10n.signUpFormNameLength;
            }
            return null;
          },
        ),
        const SizedBox(height: AppDimensions.md),
        TextFormField(
          controller: phoneController,
          enabled: !isLoading,
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (_) => onSubmit(),
          decoration: InputDecoration(
            labelText: l10n.signUpFormPhoneLabel,
            prefixIcon: const Icon(Icons.phone_outlined),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return l10n.signUpFormFieldRequired;
            }
            final phoneRegex = RegExp(r'^\+?[0-9]{9,15}$');
            if (!phoneRegex.hasMatch(value.trim().replaceAll(' ', ''))) {
              return l10n.signUpFormPhoneFormat;
            }
            return null;
          },
        ),
      ],
    );
  }
}
