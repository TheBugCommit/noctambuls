import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/presentation/bloc/url/url_bloc.dart';
import 'package:noctambuls/core/presentation/bloc/url/url_state.dart';
import 'package:noctambuls/features/auth/domain/failures/auth_failures.dart';
import 'package:noctambuls/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:noctambuls/features/auth/presentation/bloc/auth_state.dart';
import 'package:noctambuls/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:noctambuls/features/settings/presentation/pages/widgets/account_section.dart';
import 'package:noctambuls/features/settings/presentation/pages/widgets/legal_section.dart';
import 'package:noctambuls/features/settings/presentation/pages/widgets/preferences_section.dart';
import 'package:noctambuls/features/settings/presentation/pages/widgets/support_section.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    final authState = context.watch<AuthBloc>().state;
    final profileState = context.watch<ProfileBloc>().state;

    final user = authState is Authenticated ? authState.user : null;
    final profile = profileState.currentProfile;

    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthError && state.failure is DeleteAccountFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(l10n.settingsDeleteAccountError),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
        ),
        BlocListener<UrlBloc, UrlState>(
          listener: (context, state) {
            if (state is UrlActionFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(l10n.cantOpenLink),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: colorScheme.surface,
        appBar: AppBar(
          centerTitle: false,
          title: Text(l10n.settingsTitle),
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.md,
              vertical: AppDimensions.lg,
            ),
            children: [
              if (user != null && profile != null) ...[
                AccountSection(user: user, profile: profile),
                const SizedBox(height: AppDimensions.xl),
              ],
              const PreferencesSection(),
              const SizedBox(height: AppDimensions.xl),
              const SupportSection(),
              const SizedBox(height: AppDimensions.xl),
              const LegalSection(),
            ],
          ),
        ),
      ),
    );
  }
}
