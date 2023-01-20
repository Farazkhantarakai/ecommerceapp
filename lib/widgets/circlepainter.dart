import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = const Color.fromARGB(255, 233, 154, 51);
    var center = Offset(size.width / 2, size.height / 2);
    var radius = size.width / 2;
    canvas.drawCircle(center, radius, paint);
  }

  //this method run when ever it rebuilds
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
