import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/presentation/widgets/app_sheet.dart';
import 'package:noctambuls/core/presentation/widgets/qr_scanner_overlay_shape.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class QrScannerArgs {
  const QrScannerArgs({
    required this.validator,
    this.title,
    this.helperText,
    this.helpTitle,
    this.helpMessage,
    this.manualEntryModalBuilder,
  });

  final String? Function(String rawValue) validator;

  final String? title;
  final String? helperText;
  final String? helpTitle;
  final String? helpMessage;
  final Widget Function(BuildContext context)? manualEntryModalBuilder;
}

class QrScannerPage extends StatefulWidget {
  const QrScannerPage({required this.args, super.key});

  final QrScannerArgs args;

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

    // DELEGUEM LA VALIDACIÓ AL CALLBACK EXTERN!
    final resultCode = widget.args.validator(rawValue);

    if (resultCode == null || resultCode.isEmpty) {
      _showErrorThrottled();
      return;
    }

    _hasNavigated = true;
    context.pop(resultCode);
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
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _openManualEntry() async {
    if (widget.args.manualEntryModalBuilder == null) return;

    unawaited(_scannerController.stop());
    final manualCode = await AppSheet.show<String>(
      context: context,
      showDragHandle: false,
      constraints: const BoxConstraints(),
      child: widget.args.manualEntryModalBuilder!(context),
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
        title: widget.args.helpTitle ?? l10n.scannerHelpTitle,
        message: widget.args.helpMessage ?? l10n.scannerHelpMessage,
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
        centerTitle: false,
        title: Text(widget.args.title ?? l10n.scannerTitle),
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
          _QrScannerOverlay(
            helperText: widget.args.helperText ?? l10n.scannerHelperText,
            onManualEntryTap: widget.args.manualEntryModalBuilder != null
                ? _openManualEntry
                : null,
          ),
        ],
      ),
    );
  }
}

class _QrScannerOverlay extends StatelessWidget {
  const _QrScannerOverlay({
    required this.onManualEntryTap,
    required this.helperText,
  });

  final VoidCallback? onManualEntryTap;
  final String helperText;

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
              helperText,
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
        if (onManualEntryTap != null)
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

/*class QrScannerPage extends StatefulWidget {
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
          behavior: SnackBarBehavior.floating,
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
*/
