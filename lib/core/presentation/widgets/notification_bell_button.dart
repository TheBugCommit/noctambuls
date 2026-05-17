import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/presentation/bloc/notification_inbox/notification_inbox_bloc.dart';
import 'package:noctambuls/core/presentation/widgets/notification_popup.dart';

class NotificationBellButton extends StatefulWidget {
  const NotificationBellButton({super.key});

  @override
  State<NotificationBellButton> createState() => _NotificationBellButtonState();
}

class _NotificationBellButtonState extends State<NotificationBellButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _shakeController;
  int _previousCount = 0;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  void _showPopup(BuildContext context) {
    unawaited(
      showDialog<void>(
        context: context,
        builder: (_) => BlocProvider.value(
          value: context.read<NotificationInboxBloc>(),
          child: const NotificationPopup(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocConsumer<NotificationInboxBloc, NotificationInboxState>(
      listener: (context, state) {
        if (state.notifications.length > _previousCount) {
          unawaited(_shakeController.forward(from: 0));
        }
        _previousCount = state.notifications.length;
      },
      builder: (context, state) {
        return Stack(
          alignment: Alignment.center,
          children: [
            AnimatedBuilder(
              animation: _shakeController,
              builder: (context, child) {
                final angle = sin(4 * pi * _shakeController.value) * 0.12;
                return Transform.rotate(angle: angle, child: child);
              },
              child: IconButton(
                icon: const Icon(Icons.notifications_outlined),
                color: colorScheme.onSurface,
                onPressed: () => _showPopup(context),
              ),
            ),
            if (state.notifications.isNotEmpty)
              Positioned(
                top: AppDimensions.sm,
                right: AppDimensions.sm,
                child: IgnorePointer(
                  child: Container(
                    width: AppDimensions.sm,
                    height: AppDimensions.sm,
                    decoration: BoxDecoration(
                      color: colorScheme.error,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
