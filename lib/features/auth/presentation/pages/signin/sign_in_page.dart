import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/constants/app_routes.dart';
import 'package:noctambuls/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:noctambuls/features/auth/presentation/bloc/auth_state.dart';
import 'package:noctambuls/features/auth/presentation/pages/signin/widgets/SignInActions.dart';
import 'package:noctambuls/features/auth/presentation/pages/signin/widgets/SignInHeader.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

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
                  SignInActions(isLoading: state is AuthLoading),
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
