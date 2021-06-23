import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class CircleProgress extends CustomPainter {

  double value;
  Color outer;

  CircleProgress({this.value = 0.0, this.outer});

  @override
  void paint(Canvas canvas, Size size) {

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2) - 4;

    Paint outerCircle = Paint()
      ..strokeWidth = 10
      ..shader = RadialGradient(colors: [
        this.outer,
        this.outer.withOpacity(0.25)
      ]).createShader(Rect.fromCircle(center: Offset(50, 100), radius: radius))
      ..style = PaintingStyle.stroke;

    Paint completeArc = Paint()
      ..strokeWidth = 10
      ..color = this.outer.withOpacity(0.50)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;

    canvas.drawCircle(center, radius, outerCircle);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), pi / 2, pi,
        false, completeArc);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
