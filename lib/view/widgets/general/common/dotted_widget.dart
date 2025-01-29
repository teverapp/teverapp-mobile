import 'dart:ui';

import 'package:flutter/material.dart';

class DottedBorderWidget extends StatelessWidget {
  final Color borderColor;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpacing;
  final Widget child;

  const DottedBorderWidget({
    super.key,
    required this.borderColor,
    required this.strokeWidth,
    required this.dashWidth,
    required this.dashSpacing,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DottedBorderPainter(
        color: borderColor,
        strokeWidth: strokeWidth,
        dashWidth: dashWidth,
        dashSpacing: dashSpacing,
      ),
      child: child,
    );
  }
}

class DottedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpacing;

  DottedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.dashWidth,
    required this.dashSpacing,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.addRRect(RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      const Radius.circular(100),
    ));

    final dashPath = _createDashedPath(path, dashWidth, dashSpacing);
    canvas.drawPath(dashPath, paint);
  }

  Path _createDashedPath(Path path, double dashWidth, double dashSpacing) {
    final dashedPath = Path();
    for (PathMetric pathMetric in path.computeMetrics()) {
      double distance = 0.0;
      while (distance < pathMetric.length) {
        final length = dashWidth;
        dashedPath.addPath(
          pathMetric.extractPath(distance, distance + length),
          Offset.zero,
        );
        distance += dashWidth + dashSpacing;
      }
    }
    return dashedPath;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
