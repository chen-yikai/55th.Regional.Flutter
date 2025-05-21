import 'package:flutter/material.dart';

class GraphPainter extends CustomPainter {
  final List<int> preDay;
  final int maxTime;

  GraphPainter({required this.preDay, required this.maxTime});

  @override
  void paint(Canvas canvas, Size size) {
    final borderPaint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.square
      ..style = PaintingStyle.stroke;

    final progressPaint = Paint()
      ..color = Colors.deepOrangeAccent
      ..strokeWidth = 15
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final textStyle = TextStyle(
      color: Colors.black,
      fontSize: 15,
      fontWeight: FontWeight.bold,
    );

    final days = ['一', '二', '三', '四', '五', '六', '日'];

    for (int i = -1; i < 5; i++) {
      final textSpan = TextSpan(
        text: i != -1
            ? i == 4
                ? (maxTime ~/ 60).toString()
                : i == 0
                    ? "0"
                    : ""
            : "分鐘",
        style: textStyle,
      );
      final textPainter = TextPainter(
        text: textSpan,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(
        minWidth: 0,
        maxWidth: size.width,
      );

      textPainter.paint(
          canvas,
          Offset(
            50 - textPainter.width - 10,
            i != -1
                ? size.height - 50 - (70 * i) - textPainter.height
                : size.height - 40,
          ));
    }

    for (int i = 0; i < 7; i++) {
      final textSpan = TextSpan(
        text: days[i],
        style: textStyle,
      );
      final textPainter = TextPainter(
          text: textSpan,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr);
      textPainter.layout(minWidth: 0, maxWidth: size.width);
      textPainter.paint(canvas, Offset(65 + i * 50, size.height - 50 + 10));

      canvas.drawLine(
          Offset(70 + i * 50, size.height - 55),
          Offset(
              70 + i * 50,
              size.height -
                  55 -
                  preDay[i] * ((size.height - 50 - 70) / maxTime)),
          progressPaint);
    }

    canvas.drawLine(Offset(50, 50), Offset(50, size.height - 50), borderPaint);
    canvas.drawLine(Offset(50, size.height - 50),
        Offset(size.width - 20, size.height - 50), borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
