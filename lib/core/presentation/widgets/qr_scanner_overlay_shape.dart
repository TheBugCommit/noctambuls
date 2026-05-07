import 'package:flutter/material.dart';

class QrScannerOverlayShape extends ShapeBorder {
  const QrScannerOverlayShape({
    required this.borderColor,
    required this.overlayColor,
    this.borderWidth = 3.0,
    this.borderRadius = 0,
    this.borderLength = 40,
    this.cutOutSize = 250,
  });

  final Color borderColor;
  final Color overlayColor;
  final double borderWidth;
  final double borderRadius;
  final double borderLength;
  final double cutOutSize;

  @override
  EdgeInsetsGeometry get dimensions => const EdgeInsets.all(10);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) =>
      Path()..addRect(rect);

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) =>
      Path()..addRect(rect);

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    final cutOutRect = Rect.fromCenter(
      center: rect.center,
      width: cutOutSize,
      height: cutOutSize,
    );
    final backgroundPaint = Paint()
      ..color = overlayColor
      ..style = PaintingStyle.fill;

    final backgroundPath = Path()
      ..addRect(rect)
      ..addRect(cutOutRect)
      ..fillType = PathFillType.evenOdd;
    canvas.drawPath(backgroundPath, backgroundPaint);

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    final path = Path()
      ..moveTo(cutOutRect.left, cutOutRect.top + borderLength)
      ..lineTo(cutOutRect.left, cutOutRect.top)
      ..lineTo(cutOutRect.left + borderLength, cutOutRect.top)
      ..moveTo(cutOutRect.right, cutOutRect.top + borderLength)
      ..lineTo(cutOutRect.right, cutOutRect.top)
      ..lineTo(cutOutRect.right - borderLength, cutOutRect.top)
      ..moveTo(cutOutRect.left, cutOutRect.bottom - borderLength)
      ..lineTo(cutOutRect.left, cutOutRect.bottom)
      ..lineTo(cutOutRect.left + borderLength, cutOutRect.bottom)
      ..moveTo(cutOutRect.right, cutOutRect.bottom - borderLength)
      ..lineTo(cutOutRect.right, cutOutRect.bottom)
      ..lineTo(cutOutRect.right - borderLength, cutOutRect.bottom);

    canvas.drawPath(path, borderPaint);
  }

  @override
  ShapeBorder scale(double t) => this;
}
