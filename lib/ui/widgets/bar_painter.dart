import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../ui_theme.dart';

class BarPainter extends CustomPainter {
  final double width;
  final int value;
  final int checkingValueIdx;
  final int maxValue;
  final int index;

  BarPainter(
      {this.width,
        this.value,
        this.checkingValueIdx,
        this.maxValue,
        this.index});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = (checkingValueIdx != -1 && index == checkingValueIdx)
        ? Colors.red
        : blueThemeColor;

    paint.strokeWidth = width;
    paint.strokeCap = StrokeCap.round;

    var pt1 = Offset(index * this.width, maxValue.ceilToDouble());
    var pt2 = Offset(index * this.width, maxValue - this.value.ceilToDouble());
    var pt3 = Offset(index * this.width, this.value.ceilToDouble());

    canvas.drawLine(pt1, pt2, paint); // TODO - NEED TO WORK
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}