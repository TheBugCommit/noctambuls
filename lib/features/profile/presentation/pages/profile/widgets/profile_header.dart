import 'package:flutter/material.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/presentation/widgets/app_icon_text.dart';
import 'package:noctambuls/features/auth/domain/entities/auth_user.dart';
import 'package:noctambuls/features/profile/domain/entities/user_profile.dart';
import 'package:noctambuls/features/profile/presentation/pages/profile/widgets/edit_profile_button.dart';
import 'package:noctambuls/features/profile/presentation/pages/profile/widgets/qr_button.dart';
import 'package:noctambuls/features/profile/presentation/pages/widgets/formatted_profile_name.dart';
import 'package:noctambuls/features/profile/presentation/pages/widgets/user_avatar.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    required this.profile,
    required this.authUser,
    super.key,
  });

  final UserProfile profile;
  final AuthUser authUser;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final photoUrl = authUser.photoUrl;

    return Padding(
      padding: const EdgeInsets.only(
        left: AppDimensions.lg,
        right: AppDimensions.lg,
        top: AppDimensions.xl,
        bottom: AppDimensions.md,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserAvatar(
            photoUrl: photoUrl,
            radius: AppDimensions.xxl,
          ),
          const SizedBox(width: AppDimensions.lg),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: AppDimensions.xs,
                        children: [
                          FormattedProfileName(
                            fullName: profile.name,
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onSurface,
                            ),
                            maxLines: 2,
                          ),
                          AppIconText(
                            icon: Icons.email_outlined,
                            text: authUser.email,
                            color: theme.colorScheme.onSurface,
                          ),
                          AppIconText(
                            icon: Icons.phone_outlined,
                            text: profile.phone,
                            color: theme.colorScheme.onSurface,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppDimensions.sm),
                    const EditProfileButton(),
                  ],
                ),
                const SizedBox(height: AppDimensions.sm),
                if (profile.ornithologistCode != null)
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${profile.ornithologistCode}',
                          style: theme.textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.primary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: AppDimensions.sm),
                      QrButton(code: profile.ornithologistCode!),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
