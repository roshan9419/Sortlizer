import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sorting_visualization/datamodels/algorithmType.dart';
import 'package:sorting_visualization/ui/views/visualizer_viewmodel.dart';
import 'package:stacked/stacked.dart';

class VisualizerView extends StatelessWidget {
  final AlgorithmType algorithmType;

  const VisualizerView({this.algorithmType, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ViewModelBuilder<VisualizerViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text(model.getTitle(),
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
      ),
      viewModelBuilder: () => VisualizerViewModel(algorithmType),
    );
  }
}

class _VisualizerView extends ViewModelWidget<VisualizerViewModel> {
  _VisualizerView({Key key}) : super(key: key, reactive: true);

  @override
  Widget build(BuildContext context, model) {
    var theme = Theme.of(context);
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            !model.isLoading ? VisualizerContainer() : SizedBox.shrink(),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                getRoundButton("Reset", Color(0xffEBEBEB), theme.accentColor,
                    false, context, model.reset),
                FloatingActionButton.extended(
                    onPressed: () => print('Speed'),
                    heroTag: null,
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
                getRoundButton("Start", theme.primaryColor, Colors.white, true,
                    context, model.play,
                    heroTag: "play"),
              ],
            ),
            SizedBox(height: 30.0),
            Text(
              model.getTitle(),
              style: theme.textTheme.subtitle1,
            ),
            SizedBox(height: 10),
            Text(
              model.getAlgorithmDesc(),
              style: theme.textTheme.bodyText2.copyWith(
                  fontStyle: FontStyle.italic, color: theme.accentColor),
            ),
            SizedBox(height: 20),
            Text(
              "Time Complexity:",
              style: theme.textTheme.caption,
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  "Worst Case:\t",
                  style: theme.textTheme.subtitle2.copyWith(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.normal),
                ),
                Text(model.getTC(0),
                    style: theme.textTheme.subtitle2
                        .copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
            Row(
              children: [
                Text(
                  "Average Case:\t",
                  style: theme.textTheme.subtitle2.copyWith(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.normal),
                ),
                Text(model.getTC(1),
                    style: theme.textTheme.subtitle2
                        .copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
            Row(
              children: [
                Text(
                  "Best Case:\t",
                  style: theme.textTheme.subtitle2.copyWith(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.normal),
                ),
                Text(model.getTC(2),
                    style: theme.textTheme.subtitle2
                        .copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  getRoundButton(String title, Color backgroundColor, Color textColor,
      bool showIcon, BuildContext context, Function onTap,
      {String heroTag}) {
    return FloatingActionButton.extended(
        onPressed: () {
          onTap();
        },
        heroTag: heroTag,
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

class VisualizerContainer extends ViewModelWidget<VisualizerViewModel> {
  @override
  Widget build(BuildContext context, VisualizerViewModel model) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(right: 10),
        child: StreamBuilder<Object>(
            initialData: model.getNumbers(),
            stream: model.getStreamController().stream,
            builder: (context, snapshot) {
              List<int> numbers = snapshot.data;
              int counter = 0;

              return Row(
                children: numbers.map((int num) {
                  counter++;
                  return Container(
                    color: Colors.red,
                    height: model.maxNumber,
                    child: CustomPaint(
                      painter: BarPainter(
                          index: counter,
                          value: num,
                          width: MediaQuery.of(context).size.width /
                              model.getSampleSize()),
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

    canvas.drawLine(Offset(index * this.width, 0),
        Offset(index * this.width, this.value.ceilToDouble()), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
