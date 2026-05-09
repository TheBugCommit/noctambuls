import 'package:flutter/material.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';

class ObservationCardWithError extends StatelessWidget {
  const ObservationCardWithError({
    required this.child,
    required this.showError,
    super.key,
  });

  final Widget child;
  final bool showError;

  @override
  Widget build(BuildContext context) {
    if (!showError) return child;

    return Stack(
      children: [
        child,
        Positioned(
          top: AppDimensions.xs,
          right: AppDimensions.xs,
          child: Container(
            padding: const EdgeInsets.all(AppDimensions.xs),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.errorContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.location_off,
              size: AppDimensions.iconSm,
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ),
      ],
    );
  }
}
