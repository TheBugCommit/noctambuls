import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:noctambuls/features/observations/presentation/pages/observation_form/widgets/classic_compass_dial.dart';

class LiveCompassPreview extends StatelessWidget {
  const LiveCompassPreview({
    required this.size,
    super.key,
    this.fixedHeading,
  });

  final double size;
  final double? fixedHeading;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CompassEvent>(
      stream: FlutterCompass.events,
      builder: (context, snapshot) {
        final heading = fixedHeading ?? snapshot.data?.heading ?? 0;
        return ClassicCompassDial(
          heading: heading,
          size: size,
        );
      },
    );
  }
}
