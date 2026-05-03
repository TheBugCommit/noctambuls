import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/constants/app_routes.dart';
import 'package:noctambuls/core/constants/env_config.dart';
import 'package:noctambuls/core/presentation/bloc/url/url_bloc.dart';
import 'package:noctambuls/core/presentation/bloc/url/url_event.dart';
import 'package:noctambuls/core/presentation/widgets/app_button.dart';
import 'package:noctambuls/features/auth/domain/failures/auth_failures.dart';
import 'package:noctambuls/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:noctambuls/features/auth/presentation/bloc/auth_event.dart';
import 'package:noctambuls/features/auth/presentation/bloc/auth_state.dart';
import 'package:noctambuls/features/profile/presentation/pages/widgets/profile_form_fields.dart';
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

  bool _acceptedTerms = false;
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_validateFormSilently);
    _phoneController.addListener(_validateFormSilently);
  }

  @override
  void dispose() {
    _nameController.removeListener(_validateFormSilently);
    _phoneController.removeListener(_validateFormSilently);
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _validateFormSilently() {
    final isNameValid = _nameController.text.trim().length >= 3;
    final phoneRegex = RegExp(r'^\+?[0-9]{9,15}$');
    final isPhoneValid = phoneRegex.hasMatch(
      _phoneController.text.trim().replaceAll(' ', ''),
    );

    final isValid = isNameValid && isPhoneValid && _acceptedTerms;

    if (_isFormValid != isValid) {
      setState(() {
        _isFormValid = isValid;
      });
    }
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

    void popAction() {
      context.read<AuthBloc>().add(const SignOutRequested());
      if (context.canPop()) {
        context.pop();
      } else {
        context.go(AppRoutes.signin);
      }
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        popAction();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.signUpTitle),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: popAction,
          ),
        ),
        body: BlocConsumer<AuthBloc, AuthState>(
          listenWhen: (prev, curr) =>
              curr is AuthError || curr is Unauthenticated,
          listener: (context, state) {
            if (state is AuthError) {
              final isSessionExpired =
                  state.failure is ProviderTokenExpiredFailure;

              final message = isSessionExpired
                  ? l10n.signUpSessionExpired
                  : l10n.signUpError;

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
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

                            ProfileFormFields(
                              nameController: _nameController,
                              phoneController: _phoneController,
                              isLoading: isLoading,
                              onSubmit: _submit,
                            ),

                            const SizedBox(height: AppDimensions.md),
                            _TermsAndConditions(
                              value: _acceptedTerms,
                              isLoading: isLoading,
                              onChanged: (newValue) {
                                setState(() {
                                  _acceptedTerms = newValue ?? false;
                                });
                                _validateFormSilently();
                              },
                            ),

                            const Spacer(),
                            const SizedBox(height: AppDimensions.lg),

                            _SubmitButton(
                              isLoading: isLoading,
                              isValid: _isFormValid,
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

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({
    required this.isLoading,
    required this.isValid,
    required this.onSubmit,
  });

  final bool isLoading;
  final bool isValid;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const SizedBox(
        width: double.infinity,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final l10n = AppLocalizations.of(context)!;
    return SizedBox(
      height: AppDimensions.buttonHeightLg,
      child: AppButton.primary(
        onPressed: !isValid ? null : onSubmit,
        customIcon: const Icon(Icons.check),
        label: l10n.signUpSendButton,
      ),
    );
  }
}

class _TermsAndConditions extends StatelessWidget {
  const _TermsAndConditions({
    required this.value,
    required this.onChanged,
    required this.isLoading,
  });

  final bool value;
  final ValueChanged<bool?> onChanged;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Row(
      children: [
        Checkbox(
          value: value,
          activeColor: theme.colorScheme.primary,
          onChanged: isLoading ? null : onChanged,
        ),
        Expanded(
          child: Text.rich(
            TextSpan(
              text: l10n.accept_terms_prefix,
              style: theme.textTheme.bodyMedium,
              children: [
                TextSpan(
                  text: l10n.terms_and_conditions,
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      context.read<UrlBloc>().add(
                        const OpenUrlRequested(EnvConfig.termsAndConditionsUrl),
                      );
                    },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
