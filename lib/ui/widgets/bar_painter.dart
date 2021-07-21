import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BarPainter extends CustomPainter {
  final double width;
  final int value;
  final int checkingValueIdx;
  final int maxValue;
  final int index;
  final Color barColor;

  BarPainter(
      {this.width,
      this.value,
      this.checkingValueIdx,
      this.maxValue,
      this.index,
      this.barColor});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = (checkingValueIdx != -1 && index == checkingValueIdx)
        ? Colors.red
        : barColor ?? Colors.blue;

    paint.strokeWidth = width;
    paint.strokeCap = StrokeCap.round;

    var pt1 = Offset(index * width, maxValue.ceilToDouble() + 10); // Just for UI Purpose
    var pt2 = Offset(index * width, maxValue - value.ceilToDouble());
    var pt3 = Offset(index * width, value.ceilToDouble());

    // canvas.drawLine(pt1, pt1, paint); //NO
    canvas.drawLine(pt1, pt2, paint); //NEED
    // canvas.drawLine(pt1, pt3, paint); //REVERSE
    // canvas.drawLine(pt2, pt1, paint); //SAME AS NEED
    // canvas.drawLine(pt2, pt2, paint); //DOT SORT
    // canvas.drawLine(pt2, pt3, paint); //HALF-HALF SORT
    // canvas.drawLine(pt3, pt1, paint); //REVERSE
    // canvas.drawLine(pt3, pt2, paint); //HALF-HALF SORT
    // canvas.drawLine(pt3, pt3, paint); //REVERSE DOT SORT
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
