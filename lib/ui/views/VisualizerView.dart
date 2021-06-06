import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VisualizerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Bubble Sort",
            style: theme.textTheme.subtitle1.copyWith(color: Colors.white)),
        leading: IconButton(
            tooltip: "Back",
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios)),
        actions: [
          TextButton(
            onPressed: () => print('Change Algorithm'),
            child: Text("Change",
                style: theme.textTheme.caption.copyWith(color: Colors.white)),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: _VisualizerView(),
    );
  }
}

class _VisualizerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VisualizerContainer(),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                getRoundButton("Reset", Color(0xffEBEBEB), theme.accentColor,
                    false, context),
                FloatingActionButton.extended(
                    onPressed: () => print('Speed'),
                    backgroundColor: Color(0xffEBEBEB),
                    label: Row(
                      children: [
                        Text(
                          'Speed',
                          style: Theme.of(context).textTheme.subtitle1.copyWith(
                              letterSpacing: 1,
                              color: theme.accentColor,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 5),
                        Text(
                          '2x',
                          style: theme.textTheme.subtitle1.copyWith(
                              color: theme.primaryColor,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    )),
                getRoundButton(
                    "Start", theme.primaryColor, Colors.white, true, context),
              ],
            ),
            SizedBox(height: 30.0),
            Text(
              "Bubble Sort",
              style: theme.textTheme.subtitle1,
            ),
            SizedBox(height: 10),
            Text(
              "Bubble Sort is the simplest sorting algorithm that works by repeated swapping the adjacent elements if they are in wrong order.",
              style: theme.textTheme.bodyText2
                  .copyWith(fontStyle: FontStyle.italic, color: theme.accentColor),
            )
          ],
        ),
      ),
    );
  }

  Widget getRoundButton(String title, Color backgroundColor, Color textColor,
      bool showIcon, BuildContext context) {
    return FloatingActionButton.extended(
        onPressed: () => print(title),
        backgroundColor: backgroundColor,
        label: Row(
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                  letterSpacing: 1,
                  color: textColor,
                  fontWeight: FontWeight.bold),
            ),
            showIcon ? Icon(Icons.play_arrow) : SizedBox.shrink()
          ],
        ));
  }
}

class VisualizerContainer extends StatefulWidget {
  @override
  _VisualizerContainerState createState() => _VisualizerContainerState();
}

class _VisualizerContainerState extends State<VisualizerContainer> {
  List<int> _numbers = [];
  StreamController<List<int>> _streamController = new StreamController();
  double _sampleSize = 320;

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(top: 0.0),
        child: StreamBuilder<Object>(
            initialData: _numbers,
            stream: _streamController.stream,
            builder: (context, snapshot) {
              List<int> numbers = snapshot.data;
              int counter = 0;

              return Row(
                children: numbers.map((int num) {
                  counter++;
                  return Container(
                    child: CustomPaint(
                      painter: BarPainter(index: counter, value: num, width: MediaQuery.of(context).size.width / _sampleSize),
                    ),
                  );
                }).toList(),
              );
            }),
      ),
    );
  }
}

class BarPainter extends CustomPainter {
  final double width;
  final int value;
  final int index;

  BarPainter({this.width, this.value, this.index});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    if (this.value < 500 * .10) {
      paint.color = Color(0xFFDEEDCF);
    } else if (this.value < 500 * .20) {
      paint.color = Color(0xFFBFE1B0);
    } else if (this.value < 500 * .30) {
      paint.color = Color(0xFF99D492);
    } else if (this.value < 500 * .40) {
      paint.color = Color(0xFF74C67A);
    } else if (this.value < 500 * .50) {
      paint.color = Color(0xFF56B870);
    } else if (this.value < 500 * .60) {
      paint.color = Color(0xFF39A96B);
    } else if (this.value < 500 * .70) {
      paint.color = Color(0xFF1D9A6C);
    } else if (this.value < 500 * .80) {
      paint.color = Color(0xFF188977);
    } else if (this.value < 500 * .90) {
      paint.color = Color(0xFF137177);
    } else {
      paint.color = Color(0xFF0E4D64);
    }

    paint.strokeWidth = width;
    paint.strokeCap = StrokeCap.round;

    canvas.drawLine(Offset(index * this.width, 0), Offset(index * this.width, this.value.ceilToDouble()), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
