import 'dart:math';

import 'package:flutter/material.dart';

class ClockPainter extends CustomPainter {
  final int sec;

  ClockPainter({required this.sec});

  @override
  void paint(Canvas canvas, Size size) {
    double circleSize = 100;
    double handleLength = 70;
    double normalWidth = 8;
    Color themeColor = const Color(0xffFF784B);
    final center = Offset(size.width / 2, size.height / 2);

    final circlePaint = Paint()
      ..color = themeColor
      ..strokeWidth = normalWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final bgCirclePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = normalWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;
    final thinPaint = Paint()
      ..color = themeColor
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final handlePaint = Paint()
      ..color = themeColor
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, circleSize, bgCirclePaint);
    canvas.drawCircle(center, circleSize, circlePaint);

    canvas.drawLine(Offset(center.dx - 20, center.dy - circleSize - 20),
        Offset(center.dx + 20, center.dy - circleSize - 20), thinPaint);

    canvas.drawLine(Offset(center.dx - circleSize, center.dy),
        Offset(center.dx - circleSize + 15, center.dy), thinPaint);
    canvas.drawLine(Offset(center.dx + circleSize, center.dy),
        Offset(center.dx + circleSize - 15, center.dy), thinPaint);
    canvas.drawLine(Offset(center.dx, center.dy - circleSize),
        Offset(center.dx, center.dy - circleSize + 15), thinPaint);
    canvas.drawLine(Offset(center.dx, center.dy + circleSize),
        Offset(center.dx, center.dy + circleSize - 15), thinPaint);

    canvas.drawLine(center, center, circlePaint);

    final radius = (sec * 6 - 90) * (pi / 180);
    canvas.drawLine(
        center,
        Offset(center.dx + handleLength * cos(radius),
            center.dy + handleLength * sin(radius)),
        handlePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
