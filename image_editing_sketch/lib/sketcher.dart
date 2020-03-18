// using important this is essential for the app not to crash
import 'package:flutter/material.dart';

/// painter[Paint] if you did not provide the paint instance
/// default [Painter] will be used
class Sketcher extends CustomPainter {
  final List<Offset> points;
  Paint painter;
  final strokeWidth;
  Sketcher({this.points, this.strokeWidth: 2.0 ,this.painter}) {
    if (painter == null) {
      this.painter = Paint()
        ..color = Colors.redAccent
        ..strokeCap = StrokeCap.round
        ..strokeWidth = strokeWidth;
    }
  }

  @override
  bool shouldRepaint(Sketcher oldDelegate) {
    return oldDelegate.points != points;
  }

  void paint(Canvas canvas, Size size) {
    if (painter == null) {
      painter = Paint()
        ..color = Colors.redAccent
        ..strokeCap = StrokeCap.butt
        ..strokeWidth = 1.0;
    }
    // draw line

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i], points[i + 1], painter);
      }
    }
  }
}
