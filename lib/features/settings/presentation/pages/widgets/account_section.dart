import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/presentation/widgets/app_icon_text.dart';
import 'package:noctambuls/core/presentation/widgets/app_sheet.dart';
import 'package:noctambuls/features/auth/domain/entities/auth_user.dart';
import 'package:noctambuls/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:noctambuls/features/auth/presentation/bloc/auth_event.dart';
import 'package:noctambuls/features/profile/domain/entities/user_profile.dart';
import 'package:noctambuls/features/profile/presentation/pages/widgets/formatted_profile_name.dart';
import 'package:noctambuls/features/profile/presentation/pages/widgets/user_avatar.dart';
import 'package:noctambuls/features/settings/presentation/pages/widgets/section_title.dart';
import 'package:noctambuls/features/settings/presentation/pages/widgets/settings_card.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class AccountSection extends StatelessWidget {
  const AccountSection({
    required this.user,
    required this.profile,
    super.key,
  });

  final AuthUser user;
  final UserProfile profile;

  Future<void> _showDeleteAccountDialog(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;

    final confirmed = await AppSheet.showConfirm(
      context: context,
      title: l10n.settingsDeleteAccountDialogTitle,
      message: l10n.settingsDeleteAccountDialogBody,
      confirmText: l10n.settingsDeleteAccountDialogConfirm,
      cancelText: l10n.cancel,
      isDestructive: true,
    );

    if (confirmed == true && context.mounted) {
      context.read<AuthBloc>().add(const DeleteAccountRequested());
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
              onTap: () =>
                  context.read<AuthBloc>().add(const SignOutRequested()),
            ),
            const Divider(height: 1),
            ListTile(
              leading: Icon(
                Icons.delete_forever,
                color: colorScheme.error,
              ),
              title: Text(
                l10n.settingsDeleteAccount,
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
              onTap: () => _showDeleteAccountDialog(context),
            ),
          ],
        ),
      ],
    );
  }
}
