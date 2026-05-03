import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/presentation/widgets/app_icon_text.dart';
import 'package:noctambuls/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:noctambuls/features/auth/presentation/bloc/auth_event.dart';
import 'package:noctambuls/features/auth/presentation/bloc/auth_state.dart';
import 'package:noctambuls/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:noctambuls/features/profile/presentation/pages/widgets/formatted_profile_name.dart';
import 'package:noctambuls/features/profile/presentation/pages/widgets/user_avatar.dart';
import 'package:noctambuls/features/settings/presentation/widgets/language_selector.dart';
import 'package:noctambuls/features/settings/presentation/widgets/theme_selector.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final authState = context.watch<AuthBloc>().state;
    final profileState = context.watch<ProfileBloc>().state;

    final user = authState is Authenticated ? authState.user : null;
    final profile = profileState.currentProfile;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Text(l10n.settingsTitle),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.md,
          vertical: AppDimensions.lg,
        ),
        children: [
          if (user != null && profile != null) ...[
            _SectionTitle(title: l10n.settingsAccountTitle),
            _SettingsCard(
              children: [
                Padding(
                  padding: const EdgeInsets.all(AppDimensions.md),
                  child: Row(
                    children: [
                      UserAvatar(
                        photoUrl: user.photoUrl,
                        radius: AppDimensions.xl,
                      ),
                      const SizedBox(width: AppDimensions.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: AppDimensions.xs,
                          children: [
                            FormattedProfileName(fullName: profile.name),
                            AppIconText(
                              icon: Icons.email_outlined,
                              text: user.email,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.logout, color: colorScheme.error),
                  title: Text(
                    l10n.profileSignOut,
                    style: TextStyle(
                      color: colorScheme.error,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(AppDimensions.radiusLg),
                    ),
                  ),
                  onTap: () =>
                      context.read<AuthBloc>().add(const SignOutRequested()),
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.xl),
          ],

          _SectionTitle(title: l10n.settingsPreferencesTitle),
          const _SettingsCard(
            children: [
              LanguageSelector(),
              Divider(height: 1),
              ThemeSelector(),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppDimensions.sm,
        bottom: AppDimensions.sm,
      ),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  const _SettingsCard({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: Theme.of(
        context,
      ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }
}
