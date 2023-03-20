import 'package:flutter/material.dart';

class CarousolBackground extends CustomPainter {
  CarousolBackground({required this.backgroundColor});

  final Color backgroundColor;

  @override
  void paint(Canvas canvas, Size size) {
    var center = Offset(size.width / 2, size.height / 2);

    Paint paint1 = Paint()..color = backgroundColor;
    Paint paint2 = Paint()..color = Colors.white24;

    canvas.drawCircle(center, 80, paint1);
    canvas.drawCircle(center, 50, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
