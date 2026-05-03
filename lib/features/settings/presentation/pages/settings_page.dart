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
import 'package:noctambuls/features/settings/presentation/pages/widgets/section_title.dart';
import 'package:noctambuls/features/settings/presentation/pages/widgets/settings_card.dart';
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
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.md,
            vertical: AppDimensions.lg,
          ),
          children: [
            if (user != null && profile != null) ...[
              SectionTitle(title: l10n.settingsAccountTitle),
              SettingsCard(
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

            SectionTitle(title: l10n.settingsPreferencesTitle),
            const SettingsCard(
              children: [
                LanguageSelector(),
                Divider(height: 1),
                ThemeSelector(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
