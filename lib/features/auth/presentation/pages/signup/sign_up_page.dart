import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/widgets/app_button.dart';
import 'package:noctambuls/features/auth/domain/failures/auth_failures.dart';
import 'package:noctambuls/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:noctambuls/features/auth/presentation/bloc/auth_event.dart';
import 'package:noctambuls/features/auth/presentation/bloc/auth_state.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(
        SignUpRequested(
          name: _nameController.text.trim(),
          phone: _phoneController.text.trim(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.signUpTitle),
        centerTitle: true,
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listenWhen: (prev, curr) =>
            curr is AuthError || curr is Unauthenticated,
        listener: (context, state) {
          if (state is AuthError) {
            final isSessionExpired =
                state.failure is ProviderTokenExpiredFailure;

            final missatge = isSessionExpired
                ? l10n.signUpSessionExpired
                : l10n.signUpError;

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(missatge),
                backgroundColor: theme.colorScheme.error,
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;

          return SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Padding(
                    padding: const EdgeInsets.all(AppDimensions.lg),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const _HeaderSection(),
                          const SizedBox(height: AppDimensions.xl),

                          _ProfileFormFields(
                            nameController: _nameController,
                            phoneController: _phoneController,
                            isLoading: isLoading,
                            onSubmit: _submit,
                          ),

                          const Spacer(),
                          const SizedBox(height: AppDimensions.lg),

                          _SubmitButton(
                            isLoading: isLoading,
                            onSubmit: _submit,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  const _HeaderSection();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.signUpHeaderTitle,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppDimensions.sm),
        Text(
          l10n.signUpHeaderSubTitle,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _ProfileFormFields extends StatelessWidget {
  const _ProfileFormFields({
    required this.nameController,
    required this.phoneController,
    required this.isLoading,
    required this.onSubmit,
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

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({
    required this.isLoading,
    required this.onSubmit,
  });

  final bool isLoading;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    return SizedBox(
      height: AppDimensions.buttonHeightLg,
      child: AppButton.primary(
        onPressed: isLoading ? null : onSubmit,
        customIcon: isLoading
            ? SizedBox(
                width: AppDimensions.iconMd,
                height: AppDimensions.iconMd,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: theme.colorScheme.onPrimary,
                ),
              )
            : const Icon(Icons.check),
        label: isLoading ? l10n.signUpSendButtonLoading : l10n.signUpSendButton,
      ),
    );
  }
}
