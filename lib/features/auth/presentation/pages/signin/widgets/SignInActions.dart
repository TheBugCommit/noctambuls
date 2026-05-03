import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/core/presentation/widgets/app_button.dart';
import 'package:noctambuls/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:noctambuls/features/auth/presentation/bloc/auth_event.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class SignInActions extends StatelessWidget {
  const SignInActions({required this.isLoading, super.key});

  final bool isLoading;

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

    return const Column(
      children: [_GoogleSignInAction()],
    );
  }
}

class _GoogleSignInAction extends StatelessWidget {
  const _GoogleSignInAction();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: AppButton.primary(
        onPressed: () {
          context.read<AuthBloc>().add(const SignInWithGoogleRequested());
        },
        label: AppLocalizations.of(context)!.signInWithGoogle,
        icon: Icons.login,
        size: AppButtonSize.lg,
      ),
    );
  }
}
