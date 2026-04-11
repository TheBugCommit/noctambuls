import 'package:flutter/material.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/widgets/app_button.dart';

class AppBottomSheet extends StatelessWidget {
  const AppBottomSheet({
    required this.title,
    required this.primaryButton,
    this.message,
    this.content,
    this.secondaryButton,
    super.key,
  });

  final String title;
  final String? message;
  final Widget? content;

  final AppButton primaryButton;
  final AppButton? secondaryButton;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          left: AppDimensions.lg,
          right: AppDimensions.lg,
          bottom: AppDimensions.lg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppDimensions.md),

            if (message != null) ...[
              Text(
                message!,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppDimensions.lg),
            ],

            if (content != null) ...[
              content!,
              const SizedBox(height: AppDimensions.lg),
            ],

            Row(
              children: [
                if (secondaryButton != null) ...[
                  Expanded(child: secondaryButton!),
                  const SizedBox(width: AppDimensions.md),
                ],

                Expanded(child: primaryButton),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
