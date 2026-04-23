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

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            context.go(AppRoutes.home);
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  AppLocalizations.of(context)!.signInError,
                ),
                behavior: SnackBarBehavior.floating,
              ),
            );
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
                  const SizedBox(
                    width: 80,
                    height: 80,
                    child: VectorGraphic(
                      loader: AssetBytesLoader(AppAssets.taxusIcon),
                    ),
                  ),
                  const SizedBox(height: AppDimensions.lg),
                  Text(
                    AppLocalizations.of(context)!.loginTitle,
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppDimensions.sm),
                  Text(
                    AppLocalizations.of(context)!.loginSubtitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: state is AuthLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : AppButton.primary(
                            onPressed: () => context.read<AuthBloc>().add(
                              const SignInRequested(GoogleAuthCredentials()),
                            ),
                            label: AppLocalizations.of(
                              context,
                            )!.signInWithGoogle,
                            icon: Icons.login,
                            size: AppButtonSize.lg,
                          ),
                  ),
                  const SizedBox(height: AppDimensions.xl),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
