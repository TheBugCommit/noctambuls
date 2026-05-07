import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/presentation/widgets/taxus_app_bar.dart';
import 'package:noctambuls/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:noctambuls/features/auth/presentation/bloc/auth_state.dart';
import 'package:noctambuls/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:noctambuls/features/profile/presentation/bloc/profile_state.dart';
import 'package:noctambuls/features/profile/presentation/pages/profile/widgets/profile_content.dart';
import 'package:noctambuls/features/profile/presentation/pages/profile/widgets/profile_error_view.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthBloc>().state;
    if (authState is! Authenticated) return const SizedBox.shrink();

    final authUser = authState.user;
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: const TaxusAppBar(),
        body: SafeArea(
          child: BlocConsumer<ProfileBloc, ProfileState>(
            buildWhen: (previous, current) {
              if (current is ProfileError && previous is ProfileLoaded) {
                return false;
              }
              return true;
            },
            listener: (context, state) {
              if (state is ProfileUpdateSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(l10n.profileEditSuccess),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              } else if (state is ProfileError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(l10n.profileLoadError),
                    backgroundColor: colorScheme.error,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            builder: (context, state) {
              return switch (state) {
                ProfileInitial() || ProfileLoading() => const Center(
                  child: CircularProgressIndicator(),
                ),
                ProfileError(failure: final f) => ProfileErrorView(
                  failure: f,
                  userId: authUser.id,
                ),
                ProfileUpdateError(profile: final p) => Column(
                  children: [
                    Container(
                      width: double.infinity,
                      color: colorScheme.errorContainer,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.md,
                        vertical: AppDimensions.lg / 2,
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.error_outline, color: colorScheme.error),
                          const SizedBox(width: AppDimensions.md),
                          Expanded(
                            child: Text(
                              l10n.profileEditError,
                              style: TextStyle(
                                color: colorScheme.onErrorContainer,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ProfileContent(
                        profile: p,
                        authUser: authUser,
                      ),
                    ),
                  ],
                ),
                ProfileLoaded(profile: final p) ||
                ProfileUpdating(profile: final p) ||
                ProfileUpdateSuccess(profile: final p) => ProfileContent(
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
