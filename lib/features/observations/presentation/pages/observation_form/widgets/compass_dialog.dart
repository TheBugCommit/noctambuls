import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:go_router/go_router.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/presentation/utils/numerical_range_formatter.dart';
import 'package:noctambuls/core/presentation/widgets/app_button.dart';
import 'package:noctambuls/features/observations/presentation/pages/observation_form/widgets/classic_compass_dial.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class CompassDialog extends StatefulWidget {
  final double? initialHeading;

  const CompassDialog({super.key, this.initialHeading});

  @override
  State<CompassDialog> createState() => _CompassDialogState();
}

class _CompassDialogState extends State<CompassDialog> {
  double _heading = 0.0;
  bool _isManualMode = false;
  bool _hasSensor = true;
  final int degrees = 360;

  StreamSubscription<CompassEvent>? _compassSubscription;
  late final TextEditingController _manualInputController;

  @override
  void initState() {
    super.initState();
    _heading = widget.initialHeading ?? 0.0;
    _manualInputController = TextEditingController(
      text: widget.initialHeading?.toStringAsFixed(0) ?? '',
    );

    _initCompass();
  }

  void _initCompass() {
    _compassSubscription = FlutterCompass.events?.listen(
      (event) {
        if (event.heading != null) {
          if (!_isManualMode && mounted) {
            setState(() {
              _heading = event.heading!;
              _hasSensor = true;
            });
          }
        } else {
          _fallbackToManual();
        }
      },
      onError: (e) {
        _fallbackToManual();
      },
    );
  }

  void _fallbackToManual() {
    if (mounted && _hasSensor) {
      setState(() {
        _hasSensor = false;
        _isManualMode = true;
      });
    }
  }

  @override
  void dispose() {
    _compassSubscription?.cancel();
    _manualInputController.dispose();
    super.dispose();
  }

  void _onManualInputChanged(String value) {
    final normalizedValue = value.replaceAll(',', '.');
    final val = double.tryParse(normalizedValue);

    if (val != null) {
      setState(() {
        _heading = val % degrees;
      });
    }
  }

  String _getCardinalDirection(double bearing) {
    const directions = ['N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW'];
    final index = (((bearing + 22.5) % degrees) / 45).floor();
    return directions[index];
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return AlertDialog(
      title: Text(l10n.orientationTitle, textAlign: TextAlign.center),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClassicCompassDial(
              heading: _heading,
              size: 220,
            ),

            const SizedBox(height: AppDimensions.xl),

            if (_isManualMode)
              TextField(
                controller: _manualInputController,
                keyboardType: const TextInputType.numberWithOptions(
                  signed: true,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp('^-?[0-9]*[.,]?[0-9]*'),
                  ),
                  NumericalRangeFormatter(
                    min: degrees * -1.0,
                    max: degrees * 1.0,
                  ),
                ],
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
                decoration: InputDecoration(
                  labelText: l10n.compassDegreesHint,
                  suffixText: l10n.compassDegreesFormat(
                    _getCardinalDirection(_heading),
                    '',
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.md,
                    vertical: AppDimensions.sm,
                  ),
                ),
                onChanged: _onManualInputChanged,
              )
            else
              Text(
                l10n.compassDegreesFormat(
                  _getCardinalDirection(_heading),
                  _heading.toStringAsFixed(0),
                ),
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),

            const SizedBox(height: AppDimensions.md),

            if (_hasSensor)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    l10n.compassManualMode,
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(width: AppDimensions.sm),
                  Switch(
                    value: _isManualMode,
                    onChanged: (value) {
                      setState(() {
                        _isManualMode = value;
                        if (value) {
                          _manualInputController.text = _heading
                              .toStringAsFixed(0);
                        }
                      });
                    },
                  ),
                ],
              )
            else
              Text(
                l10n.compassNoSensorFallback,
                textAlign: TextAlign.center,
                style: TextStyle(color: theme.colorScheme.error),
              ),

            const SizedBox(height: AppDimensions.xl),

            AppButton.primary(
              onPressed: () => context.pop(_heading),
              label: l10n.compassFixDirection,
            ),
          ],
        ),
      ),
    );
  }
}
