import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:noctambuls/core/constants/app_assets.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/l10n/app_localizations.dart';
import 'package:vector_graphics/vector_graphics.dart';

class EmptyObservations extends StatelessWidget {
  const EmptyObservations({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture(
            const AssetBytesLoader(AppAssets.owl),
            height: AppDimensions.xxl * 1.5,
            colorFilter: ColorFilter.mode(
              colorScheme.onSurfaceVariant,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(height: AppDimensions.md),
          Text(
            l10n.noObservationsRegistered,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
