import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:noctambuls/core/constants/app_deeplinks.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/presentation/widgets/app_sheet.dart';
import 'package:noctambuls/core/presentation/widgets/qr_scanner_overlay_shape.dart';
import 'package:noctambuls/features/observations/presentation/pages/review/widgets/adaptative_manual_code.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class QrScannerPage extends StatefulWidget {
  const QrScannerPage({super.key});

  @override
  State<QrScannerPage> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage> {
  bool _hasNavigated = false;
  DateTime? _lastErrorTime;
  late final MobileScannerController _scannerController;

  @override
  void initState() {
    super.initState();
    _scannerController = MobileScannerController(
      formats: const [BarcodeFormat.qrCode],
      detectionTimeoutMs: 500,
    );
  }

  void _onDetect(BarcodeCapture capture) {
    if (_hasNavigated) return;

    final rawValue = capture.barcodes.firstOrNull?.rawValue;
    if (rawValue == null) return;

    final sanitizedValue = rawValue.replaceAll('#', '%23');
    final uri = Uri.tryParse(sanitizedValue);
    if (uri == null || !AppDeepLinks.isValidDeepLink(uri)) {
      _showErrorThrottled();
      return;
    }

    final code = AppDeepLinks.extractParticipantCode(uri);
    if (code == null || code.isEmpty) {
      _showErrorThrottled();
      return;
    }

    _hasNavigated = true;
    context.pop(code);
  }

  @override
  void dispose() {
    unawaited(_scannerController.dispose());
    super.dispose();
  }

  void _showErrorThrottled() {
    final now = DateTime.now();
    if (_lastErrorTime == null ||
        now.difference(_lastErrorTime!).inSeconds > 3) {
      _lastErrorTime = now;
      final l10n = AppLocalizations.of(context)!;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.invalidQrCode),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _openManualEntry() async {
    unawaited(_scannerController.stop());
    final manualCode = await AppSheet.show<String>(
      context: context,
      showDragHandle: false,
      constraints: const BoxConstraints(),
      child: const AdaptiveManualCodeModal(),
    );

    if (manualCode != null && mounted) {
      context.pop(manualCode);
    } else {
      if (mounted) {
        unawaited(_scannerController.start());
      }
    }
  }

  void _showHelpInfo() {
    unawaited(_scannerController.stop());

    final l10n = AppLocalizations.of(context)!;
    unawaited(
      AppSheet.showInfo(
        context: context,
        title: l10n.scannerHelpTitle,
        message: l10n.scannerHelpMessage,
        buttonText: l10n.understood,
      ).then((_) {
        if (mounted) {
          unawaited(_scannerController.start());
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: Text(l10n.scannerTitle),
        backgroundColor: theme.colorScheme.scrim.withValues(alpha: 0.5),
        foregroundColor: const Color(0xffdfe4dc),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: _showHelpInfo,
            tooltip: l10n.scannerHelpTitle,
          ),
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(controller: _scannerController, onDetect: _onDetect),
          _QrScannerOverlay(onManualEntryTap: _openManualEntry),
        ],
      ),
    );
  }
}

class _QrScannerOverlay extends StatelessWidget {
  const _QrScannerOverlay({required this.onManualEntryTap});

  final VoidCallback onManualEntryTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final cutOutSize = isPortrait ? 260.0 : 180.0;

    return Stack(
      children: [
        Container(
          decoration: ShapeDecoration(
            shape: QrScannerOverlayShape(
              borderColor: theme.colorScheme.primary,
              overlayColor: theme.colorScheme.scrim.withValues(alpha: 0.6),
              borderWidth: AppDimensions.sm,
              borderLength: AppDimensions.xl,
              cutOutSize: cutOutSize,
            ),
          ),
        ),
        if (isPortrait)
          Positioned(
            top:
                MediaQuery.of(context).padding.top +
                kToolbarHeight +
                (isPortrait ? AppDimensions.xl : AppDimensions.sm),
            left: AppDimensions.xl,
            right: AppDimensions.xl,
            child: Text(
              l10n.scannerHelperText,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium?.copyWith(
                color: const Color(0xffdfe4dc),
                fontWeight: FontWeight.w600,
                shadows: [
                  Shadow(
                    color: theme.colorScheme.scrim,
                    blurRadius: AppDimensions.sm,
                  ),
                ],
              ),
            ),
          ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.lg),
              child: FilledButton.icon(
                onPressed: onManualEntryTap,
                icon: const Icon(Icons.edit),
                label: Text(l10n.enterCodeManually),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppDimensions.md,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
