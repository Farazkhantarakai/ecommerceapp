import 'package:flutter/material.dart';
import 'dart:math' as m;

class ImageBackground extends StatelessWidget {
  ImageBackground({super.key, required this.color});
  Color color;
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DoPaint(color),
    );
  }
}

class DoPaint extends CustomPainter {
  Color? color;
  DoPaint(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.green;
    final strokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.white
      ..strokeWidth = 2.0;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = m.min(size.width, size.height) / 2;

    canvas.drawCircle(center, radius, paint);
    canvas.drawCircle(center, radius - 1, strokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    throw UnimplementedError();
  }
}
