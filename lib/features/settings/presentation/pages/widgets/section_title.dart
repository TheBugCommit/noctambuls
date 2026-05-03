import 'package:flutter/material.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppDimensions.sm,
        bottom: AppDimensions.sm,
      ),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}
