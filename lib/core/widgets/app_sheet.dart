import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:noctambuls/core/widgets/app_bottom_sheet.dart';
import 'package:noctambuls/core/widgets/app_button.dart';

class AppSheet {
  AppSheet._();

  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    bool isDismissible = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      isDismissible: isDismissible,
      showDragHandle: true,
      builder: (context) => child,
    );
  }

  static Future<void> showInfo({
    required BuildContext context,
    required String title,
    required String message,
    required String buttonText,
  }) {
    return show<void>(
      context: context,
      child: AppBottomSheet(
        title: title,
        message: message,
        primaryButton: AppButton.primary(
          label: buttonText,
          onPressed: () {
            context.pop();
          },
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
  }) {
    return show<bool>(
      context: context,
      child: AppBottomSheet(
        title: title,
        message: message,

        secondaryButton: AppButton.outline(
          label: cancelText,
          onPressed: () {
            context.pop(false);
          },
        ),

        primaryButton: isDestructive
            ? AppButton.destructive(
                label: confirmText,
                onPressed: () {
                  context.pop(true);
                },
              )
            : AppButton.primary(
                label: confirmText,
                onPressed: () {
                  context.pop(true);
                },
              ),
      ),
    );
  }
}
