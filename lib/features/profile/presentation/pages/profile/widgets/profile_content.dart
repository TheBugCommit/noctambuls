import 'package:flutter/material.dart';
import 'package:noctambuls/features/auth/domain/entities/auth_user.dart';
import 'package:noctambuls/features/profile/domain/entities/user_profile.dart';
import 'package:noctambuls/features/profile/presentation/pages/profile/widgets/profile_header.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class ProfileContent extends StatelessWidget {
  const ProfileContent({
    required this.profile,
    required this.authUser,
    super.key,
  });

  final UserProfile profile;
  final AuthUser authUser;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Expanded(
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: ProfileHeader(profile: profile, authUser: authUser),
            ),
            const SliverToBoxAdapter(
              child: Divider(height: 1),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverTabBarDelegate(
                TabBar(
                  tabs: [
                    Tab(text: l10n.profileObservationsTab),
                    Tab(text: l10n.profileParticipationsTab),
                  ],
                ),
                theme.colorScheme.surface,
              ),
            ),
          ];
        },
        body: const TabBarView(
          children: [
            _EmptyTabContent(),
            _EmptyTabContent(),
          ],
        ),
      ),
    );
  }
}

class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverTabBarDelegate(this.tabBar, this.backgroundColor);

  final TabBar tabBar;
  final Color backgroundColor;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return ColoredBox(
      color: backgroundColor,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverTabBarDelegate oldDelegate) {
    return tabBar != oldDelegate.tabBar ||
        backgroundColor != oldDelegate.backgroundColor;
  }
}

class _EmptyTabContent extends StatelessWidget {
  const _EmptyTabContent();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Text(
        l10n.profileObservationsEmpty,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
