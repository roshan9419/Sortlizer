import 'package:flutter/material.dart';
import 'package:sorting_visualization/datamodels/barType.dart';

class BarPainter extends CustomPainter {
  final double width;
  final int value;
  final int checkingValueIdx;
  final int maxValue;
  final int index;
  final Color barColor;
  final bool flagMode;
  final int arraySize;
  final BarType barType;

  BarPainter({required this.width,
    required this.value,
    required this.checkingValueIdx,
    required this.maxValue,
    required this.index,
    required this.barColor,
    this.arraySize = 100,
    this.flagMode = false,
    this.barType = BarType.DEFAULT_BAR});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    if (flagMode) {
      var flagColor;
      if (this.value <= arraySize / 3) {
        flagColor = Colors.green;
      } else if (this.value > arraySize / 3 && this.value <= arraySize / 1.5) {
        flagColor = Colors.white;
      } else {
        flagColor = Colors.orange;
      }
      paint.color = (checkingValueIdx != -1 && index == checkingValueIdx)
          ? Colors.red
          : flagColor;
    } else {
      paint.color = (checkingValueIdx != -1 && index == checkingValueIdx)
          ? Colors.red
          : barColor;
    }

    paint.strokeWidth = width;
    paint.strokeCap = StrokeCap.round;

    var pt1 = Offset(
        index * width, maxValue.ceilToDouble() + 5); // Just for UI Purpose
    var pt2 = Offset(index * width, maxValue - value.ceilToDouble());
    var pt3 = Offset(index * width, value.ceilToDouble());
    var pt4 = Offset(index * width, 10);

    if (flagMode)
      canvas.drawLine(pt1, pt4, paint); //FLAG
    else {
      if (barType == BarType.REVERSE_BAR)
        canvas.drawLine(pt1, pt3, paint);
      else if (barType == BarType.HALF_HALF)
        canvas.drawLine(pt2, pt3, paint);
      else if (barType == BarType.DOTS)
        canvas.drawLine(pt2, pt2, paint);
      else
        canvas.drawLine(pt1, pt2, paint);
    }
    // canvas.drawLine(pt1, pt2, paint); //NEED
    // canvas.drawLine(pt1, pt1, paint); //NO
    // canvas.drawLine(pt2, pt1, paint); //SAME AS NEED
    // canvas.drawLine(pt3, pt1, paint); //REVERSE
    // canvas.drawLine(pt3, pt2, paint); //HALF-HALF SORT
    // canvas.drawLine(pt3, pt3, paint); //REVERSE DOT SORT
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
