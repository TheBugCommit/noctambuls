import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/presentation/widgets/app_button.dart';

class AppDialog extends StatelessWidget {
  const AppDialog({
    required this.title,
    required this.primaryButton,
    required this.content,
    this.secondaryButton,
    this.icon,
    this.iconColor,
    super.key,
  });

  final String title;
  final Widget primaryButton;
  final Widget content;
  final Widget? secondaryButton;
  final IconData? icon;
  final Color? iconColor;

  static Widget _buildTextMessage(
    BuildContext context,
    String message,
  ) {
    return Text(
      message,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );
  }

  static Future<void> showInfo({
    required BuildContext context,
    required String title,
    required String message,
    required String buttonText,
    IconData? icon,
    Color? iconColor,
  }) {
    return showDialog<void>(
      context: context,
      builder: (context) => AppDialog(
        title: title,
        content: _buildTextMessage(context, message),
        icon: icon,
        iconColor: iconColor,
        primaryButton: AppButton.primary(
          label: buttonText,
          onPressed: () => context.pop(),
        ),
      ),
    );
  }

  static Future<bool?> showConfirm({
    required BuildContext context,
    required String title,
    required String message,
    required String confirmText,
    required String cancelText,
    bool isDestructive = false,
    IconData? icon,
    Color? iconColor,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AppDialog(
        title: title,
        content: _buildTextMessage(context, message),
        icon: icon,
        iconColor: iconColor,
        secondaryButton: TextButton(
          onPressed: () => context.pop(false),
          child: Text(cancelText),
        ),
        primaryButton: isDestructive
            ? AppButton.destructive(
                label: confirmText,
                onPressed: () => context.pop(true),
              )
            : AppButton.primary(
                label: confirmText,
                onPressed: () => context.pop(true),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      icon: icon != null
          ? Icon(
              icon,
              size: AppDimensions.iconXl,
              color: iconColor ?? theme.colorScheme.primary,
            )
          : null,

      title: Text(
        title,
        textAlign: icon != null ? TextAlign.center : TextAlign.start,
        style: theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),

      content: SingleChildScrollView(child: content),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
      ),

      // Accions
      actionsAlignment: MainAxisAlignment.end,
      actionsPadding: const EdgeInsets.fromLTRB(
        AppDimensions.lg,
        0,
        AppDimensions.lg,
        AppDimensions.lg,
      ),
      actions: [
        ?secondaryButton,
        primaryButton,
      ],
    );
  }
}
