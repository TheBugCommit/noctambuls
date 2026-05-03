import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
          maxLength: 40,
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            labelText: l10n.signUpFormNameLabel,
            prefixIcon: const Icon(Icons.person_outline),
            counterText: '',
            filled: true,
            fillColor: Theme.of(
              context,
            ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.error,
                width: 1.5,
              ),
            ),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return l10n.signUpFormFieldRequired;
            }
            if (value.trim().length < 3) {
              return l10n.signUpFormNameLength;
            }
            if (value.trim().length > 40) {
              return 'El nom no pot superar els 40 caràcters'; // O crida al teu l10n si ho tens traduït
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
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9+\s]')),
          ],
          decoration: InputDecoration(
            labelText: l10n.signUpFormPhoneLabel,
            hintText: '+34 600 000 000',
            prefixIcon: const Icon(Icons.phone_outlined),
            filled: true,
            fillColor: Theme.of(
              context,
            ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.error,
                width: 1.5,
              ),
            ),
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
