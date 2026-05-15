import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:noctambuls/core/presentation/widgets/app_bottom_sheet.dart';
import 'package:noctambuls/core/presentation/widgets/app_button.dart';
import 'package:noctambuls/core/presentation/widgets/app_sheet.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class CensusConfirmationSheet {
  static Future<void> show(BuildContext context, VoidCallback onConfirm) async {
    final l10n = AppLocalizations.of(context)!;

    final shouldStart = await AppSheet.show<bool>(
      context: context,
      child: Builder(
        builder: (sheetContext) {
          return AppBottomSheet(
            title: l10n.censusConfirmStartTitle,
            message: l10n.censusWarningPoint,
            secondaryButton: AppButton.outline(
              label: l10n.cancel,
              onPressed: () => sheetContext.pop(false),
            ),

            primaryButton: AppButton.primary(
              label: l10n.censusConfirmStartButton,
              onPressed: () => sheetContext.pop(true),
            ),
          );
        },
      ),
    );

    if (shouldStart == true && context.mounted) {
      onConfirm();
    }
  }
}
