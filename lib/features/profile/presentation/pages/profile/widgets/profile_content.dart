import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/constants/app_routes.dart';
import 'package:noctambuls/features/auth/domain/entities/auth_user.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_list_bloc.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_list_event.dart';
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
          _OwnSessionsTab(),
          _ParticipatedSessionsTab(),
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

class _OwnSessionsTab extends StatefulWidget {
  const _OwnSessionsTab();

  @override
  State<_OwnSessionsTab> createState() => _OwnSessionsTabState();
}

class _OwnSessionsTabState extends State<_OwnSessionsTab>
    with AutomaticKeepAliveClientMixin {
  final _scrollController = ScrollController();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    context.read<SessionListBloc>().add(
      const FetchHistoryRequested(isRefresh: false),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  bool _onScroll(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification &&
        notification.metrics.pixels >=
            notification.metrics.maxScrollExtent - 200) {
      final state = context.read<SessionListBloc>().state;
      if (state is SessionListData) {
        if (!state.isLoadingHistory && state.hasMoreHistory) {
          context.read<SessionListBloc>().add(HistoryScrollReachedEnd());
        }
      }
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocBuilder<SessionListBloc, SessionListState>(
      builder: (context, state) {
        if (state is SessionListInitial) {
          return const Center(child: CircularProgressIndicator());
        }
        final data = state as SessionListData;
        return NotificationListener<ScrollNotification>(
          onNotification: _onScroll,
          child: RefreshIndicator(
            onRefresh: () async {
              context.read<SessionListBloc>().add(
                const FetchHistoryRequested(isRefresh: true),
              );
            },
            child: _SessionList(
              sessions: data.ownSessions,
              isLoadingMore: data.isLoadingHistory,
            ),
          ),
        );
      },
    );
  }
}

class _ParticipatedSessionsTab extends StatefulWidget {
  const _ParticipatedSessionsTab();

  @override
  State<_ParticipatedSessionsTab> createState() =>
      _ParticipatedSessionsTabState();
}

class _ParticipatedSessionsTabState extends State<_ParticipatedSessionsTab>
    with AutomaticKeepAliveClientMixin {
  final _scrollController = ScrollController();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    context.read<SessionListBloc>().add(
      const FetchParticipatedRequested(isRefresh: false),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  bool _onScroll(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification &&
        notification.metrics.pixels >=
            notification.metrics.maxScrollExtent - 200) {
      final state = context.read<SessionListBloc>().state;
      if (state is SessionListData) {
        if (!state.isLoadingParticipated && state.hasMoreParticipated) {
          context.read<SessionListBloc>().add(ParticipatedScrollReachedEnd());
        }
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocBuilder<SessionListBloc, SessionListState>(
      builder: (context, state) {
        if (state is SessionListInitial) {
          return const Center(child: CircularProgressIndicator());
        }
        final data = state as SessionListData;
        return NotificationListener<ScrollNotification>(
          onNotification: _onScroll,
          child: RefreshIndicator(
            onRefresh: () async {
              context.read<SessionListBloc>().add(
                const FetchParticipatedRequested(isRefresh: true),
              );
            },
            child: _SessionList(
              sessions: data.participatedSessions,
              isLoadingMore: data.isLoadingParticipated,
            ),
          ),
        );
      },
    );
  }
}

class _SessionList extends StatelessWidget {
  const _SessionList({
    required this.sessions,
    required this.isLoadingMore,
  });

  final List<ObservationSession> sessions;
  final bool isLoadingMore;

  @override
  Widget build(BuildContext context) {
    if (sessions.isEmpty && !isLoadingMore) {
      return const _EmptyTabContent();
    }

    final itemCount = sessions.length + (isLoadingMore ? 1 : 0);

    return ListView.builder(
      padding: const EdgeInsets.all(AppDimensions.md),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        if (index == sessions.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: AppDimensions.md),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final session = sessions[index];

        return SessionCard(
          session: session,
          onTap: () {
            if (session.isObserving) {
              unawaited(context.push(AppRoutes.observing, extra: session));
            } else {
              unawaited(context.push(AppRoutes.review, extra: session));
            }
          },
          onRetrySync: () {
            context.read<SessionListBloc>().add(
              RetrySyncSessionRequested(session.id),
            );
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
