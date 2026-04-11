import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/constants/app_routes.dart';
import 'package:noctambuls/core/widgets/app_sheet.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_lifecycle_bloc.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_lifecycle_event.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

enum _ObservingMenuOption { guide, delete }

class PopupMenuObserving extends StatelessWidget {
  const PopupMenuObserving({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return PopupMenuButton<_ObservingMenuOption>(
      icon: const Icon(Icons.more_vert),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
      ),
      onSelected: (result) async {
        switch (result) {
          case _ObservingMenuOption.guide:
            context.go(AppRoutes.guide);
          case _ObservingMenuOption.delete:
            final isConfirmed = await AppSheet.showConfirm(
              context: context,
              title: l10n.confirmDeleteSessionTitle,
              message: l10n.confirmDeleteSessionMessage,
              confirmText: l10n.confirmDelete,
              cancelText: l10n.cancel,
              isDestructive: true,
            );
            if (!context.mounted) return;

            if (isConfirmed == true) {
              context.read<SessionLifecycleBloc>().add(DeleteActiveSession());
            }
        }
      },
      itemBuilder: (ctx) => <PopupMenuEntry<_ObservingMenuOption>>[
        PopupMenuItem<_ObservingMenuOption>(
          value: _ObservingMenuOption.guide,
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
        PopupMenuItem<_ObservingMenuOption>(
          value: _ObservingMenuOption.delete,
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
