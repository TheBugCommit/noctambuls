import 'package:flutter/material.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.md,
        vertical: AppDimensions.sm,
      ),
      child: SafeArea(
        child: child,
      ),
    );
  }
}
