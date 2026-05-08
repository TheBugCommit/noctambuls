import 'dart:async';

import 'package:flutter/material.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/domain/enums/location_source.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class AnimatedPulseLocation extends StatefulWidget {
  const AnimatedPulseLocation({
    required this.session,
    required this.onPressed,
    super.key,
  });

  final ObservationSession session;
  final VoidCallback onPressed;

  @override
  State<AnimatedPulseLocation> createState() => _AnimatedPulseLocationState();
}

class _AnimatedPulseLocationState extends State<AnimatedPulseLocation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isDisposed = false;

  bool get _locationIsGPS =>
      widget.session.location?.locationSource == LocationSource.gps;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        _controller.reset();
        await Future<Duration>.delayed(const Duration(seconds: 4));
        if (!_isDisposed && _shouldAnimate()) {
          unawaited(_controller.forward());
        }
      }
    });

    _checkAnimation();
  }

  @override
  void didUpdateWidget(AnimatedPulseLocation oldWidget) {
    super.didUpdateWidget(oldWidget);
    _checkAnimation();
  }

  bool _shouldAnimate() {
    final hasError =
        widget.session.locationError != null && widget.session.location == null;
    return _locationIsGPS && !hasError;
  }

  void _checkAnimation() {
    if (_shouldAnimate()) {
      if (!_controller.isAnimating && _controller.isDismissed) {
        unawaited(_controller.forward());
      }
    } else {
      _controller
        ..stop()
        ..reset();
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final hasError =
        widget.session.locationError != null && widget.session.location == null;
    final l10n = AppLocalizations.of(context)!;

    if (hasError) {
      return IconButton(
        icon: const Icon(Icons.location_off),
        color: colorScheme.error,
        onPressed: widget.onPressed,
        tooltip: l10n.locationErrorTooltip,
      );
    }

    if (!_locationIsGPS) {
      return IconButton(
        icon: const Icon(Icons.location_on),
        color: colorScheme.tertiary,
        onPressed: widget.onPressed,
        tooltip: l10n.locationManualTooltip,
      );
    }

    return Tooltip(
      message: l10n.locationAutoTooltip,
      child: GestureDetector(
        onTap: widget.onPressed,
        behavior: HitTestBehavior.opaque,
        child: SizedBox(
          width: AppDimensions.xxl,
          height: AppDimensions.xxl,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final curve = Curves.easeOutQuad.transform(_controller.value);
              final waveOpacity = _controller.isAnimating
                  ? (1.0 - curve) * 0.5
                  : 0.0;

              return Stack(
                alignment: Alignment.center,
                children: [
                  Transform.scale(
                    scale: 1.0 + (curve * 0.5),
                    child: Opacity(
                      opacity: waveOpacity,
                      child: Container(
                        width: AppDimensions.lg,
                        height: AppDimensions.lg,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colorScheme.secondary,
                        ),
                      ),
                    ),
                  ),
                  Icon(Icons.location_on, color: colorScheme.primary),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
