import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/presentation/widgets/app_text_field.dart';
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
        AppTextField(
          controller: nameController,
          enabled: !isLoading,
          maxLength: 40,
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.words,
          label: l10n.signUpFormNameLabel,
          prefixIcon: Icons.person_outline,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return l10n.signUpFormFieldRequired;
            }
            if (value.trim().length < 3) {
              return l10n.signUpFormNameLength;
            }
            if (value.trim().length > 40) {
              return l10n.signUpFormNameMaxLength;
            }
            return null;
          },
        ),
        const SizedBox(height: AppDimensions.md),
        AppTextField(
          controller: phoneController,
          enabled: !isLoading,
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (_) => onSubmit(),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9+\s]')),
          ],
          label: l10n.signUpFormPhoneLabel,
          hintText: '+34 600 000 000',
          prefixIcon: Icons.phone_outlined,
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
