import 'package:flutter/material.dart';

class CirclePainter extends CustomPainter {
  CirclePainter({required this.radius1, required this.radius2});
  final double radius1;
  final double radius2;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = const Color.fromARGB(255, 88, 104, 245);
    var center = Offset(size.width / 2, size.height / 2);
    // var innerPaint = Paint()..color = Colors.white.withOpacity(0.4);
    var newInner = Paint()..color = Colors.white.withOpacity(0.4);

    // canvas.drawCircle(center, 10, innerPaint);
    canvas.drawCircle(center, radius1, newInner);
    canvas.drawCircle(center, radius2, paint);
  }

  //this method run when ever it rebuilds
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
