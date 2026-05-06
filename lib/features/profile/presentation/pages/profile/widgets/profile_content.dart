import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/features/auth/domain/entities/auth_user.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_list_bloc.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_list_state.dart';
import 'package:noctambuls/features/observations/presentation/shared_widgets/session_card.dart';
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

    return NestedScrollView(
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
          _ObservingSessions(),
          _EmptyTabContent(),
        ],
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

class _ObservingSessions extends StatelessWidget {
  const _ObservingSessions();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionListBloc, SessionListState>(
      builder: (context, state) {
        switch (state) {
          case SessionListLoading():
            return const Center(child: CircularProgressIndicator());
          case SessionListLoaded():
            return _SessionList(sessions: state.sessions);
          case SessionListError():
            return const _SessionListError();
        }
      },
    );
  }
}

class _SessionListError extends StatelessWidget {
  const _SessionListError();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error_outline,
            size: AppDimensions.xxl,
            color: theme.colorScheme.error,
          ),
          const SizedBox(height: AppDimensions.md),
          Text(
            l10n.errorLoadingObservationSessions,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}

class _SessionList extends StatelessWidget {
  const _SessionList({required this.sessions});

  final List<ObservationSession> sessions;

  @override
  Widget build(BuildContext context) {
    if (sessions.isEmpty) {
      return const _EmptyTabContent();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppDimensions.md),
      itemCount: sessions.length,
      itemBuilder: (context, index) {
        final session = sessions[index];

        return SessionCard(
          session: session,
          onTap: () {
            // Lògica de navegació
          },
        );
      },
    );
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
