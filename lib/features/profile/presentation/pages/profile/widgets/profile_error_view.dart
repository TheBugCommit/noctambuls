import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/presentation/widgets/app_button.dart';
import 'package:noctambuls/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:noctambuls/features/profile/presentation/bloc/profile_event.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class ProfileErrorView extends StatelessWidget {
  const ProfileErrorView({
    required this.failure,
    required this.userId,
    super.key,
  });

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
