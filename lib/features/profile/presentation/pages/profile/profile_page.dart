import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/constants/app_routes.dart';
import 'package:noctambuls/core/presentation/widgets/app_bottom_sheet.dart';
import 'package:noctambuls/core/presentation/widgets/app_button.dart';
import 'package:noctambuls/core/presentation/widgets/app_sheet.dart';
import 'package:noctambuls/core/presentation/widgets/taxus_app_bar.dart';
import 'package:noctambuls/features/auth/domain/entities/auth_user.dart';
import 'package:noctambuls/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:noctambuls/features/auth/presentation/bloc/auth_event.dart';
import 'package:noctambuls/features/auth/presentation/bloc/auth_state.dart';
import 'package:noctambuls/features/profile/domain/entities/user_profile.dart';
import 'package:noctambuls/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:noctambuls/features/profile/presentation/bloc/profile_event.dart';
import 'package:noctambuls/features/profile/presentation/bloc/profile_state.dart';
import 'package:noctambuls/l10n/app_localizations.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthBloc>().state;

    if (authState is! Authenticated) return const SizedBox.shrink();

    final authUser = authState.user;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: const TaxusAppBar(),
        body: SafeArea(
          child: BlocConsumer<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state is ProfileUpdateSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      AppLocalizations.of(context)!.profileEditSuccess,
                    ),
                  ),
                );
              }
            },
            builder: (context, state) {
              return switch (state) {
                ProfileInitial() || ProfileLoading() => const Center(
                  child: CircularProgressIndicator(),
                ),
                ProfileError(failure: final f) => _ProfileErrorView(
                  failure: f,
                  userId: authUser.id,
                ),
                ProfileLoaded(profile: final p) ||
                ProfileUpdating(profile: final p) ||
                ProfileUpdateSuccess(profile: final p) ||
                ProfileUpdateError(profile: final p) => _ProfileContent(
                  profile: p,
                  authUser: authUser,
                ),
              };
            },
          ),
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

class _ProfileContent extends StatelessWidget {
  const _ProfileContent({required this.profile, required this.authUser});

  final UserProfile profile;
  final AuthUser authUser;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Column(
      children: [
        Expanded(
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                  child: _ProfileHeader(profile: profile, authUser: authUser),
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
        ),
        const _SignOutTile(),
      ],
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.profile, required this.authUser});

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
          CircleAvatar(
            radius: AppDimensions.xxl,
            backgroundColor: theme.colorScheme.surfaceContainerHigh,
            backgroundImage: photoUrl != null ? NetworkImage(photoUrl) : null,
            child: photoUrl == null
                ? Icon(
                    Icons.person,
                    size: AppDimensions.xxl,
                    color: theme.colorScheme.onSurfaceVariant,
                  )
                : null,
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
                          Text(
                            profile.name,
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onSurface,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            authUser.email,
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: theme.colorScheme.onSurface,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            profile.phone,
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: theme.colorScheme.onSurface,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppDimensions.sm),
                    const _EditProfileButton(),
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
                      _QrButton(code: profile.ornithologistCode!),
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

class _EditProfileButton extends StatelessWidget {
  const _EditProfileButton();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return IconButton(
      icon: const Icon(Icons.edit_outlined),
      tooltip: l10n.profileEditTitle,
      onPressed: () => context.push(AppRoutes.profileEdit),
      style: IconButton.styleFrom(
        backgroundColor: colorScheme.secondaryContainer, // Fons sòlid
        foregroundColor: colorScheme.onSecondaryContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
        ),
        padding: const EdgeInsets.all(AppDimensions.sm),
      ),
    );
  }
}

class _QrButton extends StatelessWidget {
  const _QrButton({required this.code});

  final String code;

  void _showQrSheet(BuildContext context) {
    unawaited(
      AppSheet.show<void>(
        context: context,
        child: _QrBottomSheetContent(code: code),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    // NOU: Format idèntic al botó d'editar!
    return IconButton(
      icon: const Icon(Icons.qr_code),
      tooltip: l10n.profileShowQr,
      onPressed: () => _showQrSheet(context),
      style: IconButton.styleFrom(
        backgroundColor: colorScheme.secondaryContainer,
        foregroundColor: colorScheme.onSecondaryContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
        ),
        padding: const EdgeInsets.all(AppDimensions.sm),
      ),
    );
  }
}

class _QrBottomSheetContent extends StatelessWidget {
  const _QrBottomSheetContent({required this.code});

  final String code;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return AppBottomSheet(
      title: l10n.profileQrDialogTitle,
      content: Center(
        child: Container(
          padding: const EdgeInsets.all(AppDimensions.md),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
            border: Border.all(
              color: colorScheme.outlineVariant,
            ),
          ),
          child: QrImageView(
            data: code,
            size: AppDimensions.xxl * 4,
          ),
        ),
      ),
      primaryButton: AppButton.primary(
        label: MaterialLocalizations.of(context).okButtonLabel,
        onPressed: () => context.pop(),
      ),
    );
  }
}

class _ProfileErrorView extends StatelessWidget {
  const _ProfileErrorView({required this.failure, required this.userId});

  final Object failure;
  final String userId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error_outline,
            size: AppDimensions.xxl,
            color: colorScheme.error,
          ),
          const SizedBox(height: AppDimensions.md),
          Text(
            l10n.profileLoadError,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: AppDimensions.md),
          AppButton.primary(
            onPressed: () => context.read<ProfileBloc>().add(
              ProfileLoadRequested(userId: userId),
            ),
            label: l10n.profileRetry,
          ),
        ],
      ),
    );
  }
}

class _EmptyTabContent extends StatelessWidget {
  const _EmptyTabContent();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Cap dada disponible encara.',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

class _SignOutTile extends StatelessWidget {
  const _SignOutTile();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppDimensions.sm),
        child: TextButton.icon(
          onPressed: () =>
              context.read<AuthBloc>().add(const SignOutRequested()),
          icon: Icon(Icons.logout, color: theme.colorScheme.error),
          label: Text(
            l10n.profileSignOut,
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.error,
            ),
          ),
        ),
      ),
    );
  }
}
