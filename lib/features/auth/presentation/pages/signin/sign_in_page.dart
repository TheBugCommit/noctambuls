import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:noctambuls/core/constants/app_assets.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/constants/app_routes.dart';
import 'package:noctambuls/core/widgets/app_button.dart';
import 'package:noctambuls/features/auth/domain/entities/auth_credentials.dart';
import 'package:noctambuls/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:noctambuls/features/auth/presentation/bloc/auth_event.dart';
import 'package:noctambuls/features/auth/presentation/bloc/auth_state.dart';
import 'package:noctambuls/l10n/app_localizations.dart';
import 'package:vector_graphics/vector_graphics.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            context.go(AppRoutes.home);
          } else if (state is AuthError) {
            _showErrorSnackBar(context);
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.xl,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  const SignInHeader(),
                  const Spacer(),
                  SignInActionArea(isLoading: state is AuthLoading),
                  const SizedBox(height: AppDimensions.xl),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showErrorSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context)!.signInError),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

class SignInHeader extends StatelessWidget {
  const SignInHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context)!;

    return Column(
      children: [
        const SizedBox(
          width: 80,
          height: 80,
          child: VectorGraphic(
            loader: AssetBytesLoader(AppAssets.taxusIcon),
          ),
        ),
        const SizedBox(height: AppDimensions.lg),
        Text(
          localizations.loginTitle,
          style: theme.textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppDimensions.sm),
        Text(
          localizations.loginSubtitle,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

/// Widget que gestiona l'àrea d'acció (Botó o Loading)
class SignInActionArea extends StatelessWidget {
  const SignInActionArea({required this.isLoading, super.key});

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

    return SizedBox(
      width: double.infinity,
      child: AppButton.primary(
        onPressed: () {
          context.read<AuthBloc>().add(
            const SignInRequested(GoogleAuthCredentials()),
          );
        },
        label: AppLocalizations.of(context)!.signInWithGoogle,
        icon: Icons.login,
        size: AppButtonSize.lg,
      ),
    );
  }
}
