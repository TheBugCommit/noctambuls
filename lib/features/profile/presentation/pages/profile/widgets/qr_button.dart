import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/presentation/widgets/app_bottom_sheet.dart';
import 'package:noctambuls/core/presentation/widgets/app_button.dart';
import 'package:noctambuls/core/presentation/widgets/app_sheet.dart';
import 'package:noctambuls/l10n/app_localizations.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrButton extends StatelessWidget {
  const QrButton({required this.code, super.key});

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
        label: AppLocalizations.of(context)!.profileQrDialogClose,
        onPressed: () => context.pop(),
      ),
    );
  }
}
