import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:noctambuls/core/widgets/app_button.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_lifecycle_bloc.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_lifecycle_event.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class DeleteSessionDialog extends StatelessWidget {
  const DeleteSessionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(l10n.deleteSessionTitle),
      content: Text(l10n.deleteSessionBody),
      actions: [
        AppButton(
          label: l10n.back,
          style: AppButtonStyle.ghost,
          onPressed: () => context.pop(),
        ),
        AppButton.destructive(
          label: l10n.delete,
          onPressed: () {
            context.pop();
            context.read<SessionLifecycleBloc>().add(DeleteActiveSession());
          },
        ),
      ],
    );
  }
}
