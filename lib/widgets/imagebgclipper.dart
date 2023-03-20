import 'package:flutter/material.dart';

class ImageBgPainter extends CustomPainter {
  ImageBgPainter(
      {required this.newColor, required this.radius1, required this.radius2});

  Color newColor;
  final double radius1;
  final double radius2;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = newColor.withOpacity(0.5);
    final center = Offset(size.width / 2, size.height / 2);
    var paint2 = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, radius1, paint);
    canvas.drawCircle(center, radius2, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
