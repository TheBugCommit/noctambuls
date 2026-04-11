import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/constants/app_routes.dart';
import 'package:noctambuls/features/observations/presentation/shared_widgets/delete_session_dialog.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class PopupMenuObserving extends StatelessWidget {
  const PopupMenuObserving({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
      ),
      onSelected: (result) {
        switch (result) {
          case 'guide':
            context.go(AppRoutes.guide);
          case 'delete':
            unawaited(
              showDialog<void>(
                context: context,
                builder: (_) => const DeleteSessionDialog(),
              ),
            );
        }
      },
      itemBuilder: (ctx) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'guide',
          child: Row(
            children: [
              Icon(Icons.auto_stories_outlined, color: colorScheme.onSurface),
              const SizedBox(width: AppDimensions.sm),
              Text(
                l10n.guideLabel,
                style: TextStyle(color: colorScheme.onSurface),
              ),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'delete',
          child: Row(
            children: [
              Icon(Icons.delete_outline, color: colorScheme.error),
              const SizedBox(width: AppDimensions.sm),
              Text(l10n.delete, style: TextStyle(color: colorScheme.error)),
            ],
          ),
        ),
      ],
    );
  }
}
