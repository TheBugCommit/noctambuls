import 'package:flutter/material.dart';
import 'package:noctambuls/core/constants/app_assets.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/l10n/app_localizations.dart';
import 'package:vector_graphics/vector_graphics.dart';

class SignInHeader extends StatelessWidget {
  const SignInHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context)!;

    return Column(
      children: [
        const SizedBox(
          width: 80,
          height: 80,
          child: VectorGraphic(
            loader: AssetBytesLoader(AppAssets.taxusIcon),
          ),
        ),
        const SizedBox(height: AppDimensions.lg),
        Text(
          localizations.loginTitle,
          style: theme.textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppDimensions.sm),
        Text(
          localizations.loginSubtitle,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
