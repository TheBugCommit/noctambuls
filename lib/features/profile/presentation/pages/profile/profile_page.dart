import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                ProfileError(failure: final f) => ProfileErrorView(
                  failure: f,
                  userId: authUser.id,
                ),
                ProfileLoaded(profile: final p) ||
                ProfileUpdating(profile: final p) ||
                ProfileUpdateSuccess(profile: final p) ||
                ProfileUpdateError(profile: final p) => ProfileContent(
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
