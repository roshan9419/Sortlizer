import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sorting_visualization/datamodels/algorithmType.dart';
import 'package:sorting_visualization/ui/views/visualizer_viewmodel.dart';
import 'package:sorting_visualization/ui/widgets/code_viewer.dart';
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
              style: theme.textTheme.subtitle1.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1)),
          centerTitle: true,
          leading: IconButton(
              tooltip: "Back",
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back_ios, color: Colors.white)),
          actions: [
            IconButton(
              onPressed: () => print('hll'),
              icon: Icon(
                Icons.code,
                color: Colors.white,
              ),
              tooltip: "View Code",
            ),
            TextButton(
              onPressed: () {
                model.changeSortingTheme();
              },
              child: Text("Change",
                  style: theme.textTheme.caption.copyWith(color: Colors.white)),
            ),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          !model.isLoading ? VisualizerContainer() : SizedBox.shrink(),
          SizedBox(height: 10.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FloatingActionButton.extended(
                    onPressed: () {
                      model.reset();
                    },
                    heroTag: null,
                    backgroundColor: Color(0xffEBEBEB),
                    label: Row(
                      children: [
                        Text(
                          "Reset",
                          style: Theme.of(context).textTheme.subtitle1.copyWith(
                              letterSpacing: 1,
                              color: theme.accentColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
                FloatingActionButton.extended(
                    onPressed: () {
                      model.updateSpeed();
                    },
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
                          '${model.currentDrnIdx + 1}x',
                          style: theme.textTheme.subtitle1.copyWith(
                              color: theme.primaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    )),
                FloatingActionButton.extended(
                    onPressed: () {
                      model.onActionBtn();
                    },
                    heroTag: "play",
                    backgroundColor: theme.primaryColor,
                    label: Row(
                      children: [
                        Text(
                          model.isSorting ? "Stop" : "Start",
                          style: Theme.of(context).textTheme.subtitle1.copyWith(
                              letterSpacing: 1,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        model.isSorting
                            ? Icon(Icons.stop)
                            : Icon(Icons.play_arrow)
                      ],
                    )),
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: getAlgorithmContent(context, model)),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CodeViewer(codeContent: model.getAlgorithmCode()),
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }

  getAlgorithmContent(BuildContext context, VisualizerViewModel model) {
    var theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text(
          model.getTitle(),
          style: theme.textTheme.subtitle1
              .copyWith(color: theme.primaryColor, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text(
          model.getAlgorithmDesc(),
          style: theme.textTheme.bodyText2
              .copyWith(fontStyle: FontStyle.italic, color: theme.accentColor),
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
                  fontStyle: FontStyle.italic, fontWeight: FontWeight.normal),
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
                  fontStyle: FontStyle.italic, fontWeight: FontWeight.normal),
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
                  fontStyle: FontStyle.italic, fontWeight: FontWeight.normal),
            ),
            Text(model.getTC(2),
                style: theme.textTheme.subtitle2
                    .copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
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
                    height: model.maxNumber,
                    child: CustomPaint(
                      painter: BarPainter(
                          index: counter,
                          value: num,
                          colorScheme: model.colorScheme,
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
  final List<Color> colorScheme;

  BarPainter({this.width, this.value, this.index, this.colorScheme});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    if (this.value < 500 * .10) {
      paint.color = colorScheme[0];
    } else if (this.value < 500 * .20) {
      paint.color = colorScheme[1];
    } else if (this.value < 500 * .30) {
      paint.color = colorScheme[2];
    } else if (this.value < 500 * .40) {
      paint.color = colorScheme[3];
    } else if (this.value < 500 * .50) {
      paint.color = colorScheme[4];
    } else if (this.value < 500 * .60) {
      paint.color = colorScheme[5];
    } else if (this.value < 500 * .70) {
      paint.color = colorScheme[6];
    } else if (this.value < 500 * .80) {
      paint.color = colorScheme[7];
    } else if (this.value < 500 * .90) {
      paint.color = colorScheme[8];
    } else {
      paint.color = colorScheme[9];
    }

    paint.strokeWidth = width;
    paint.strokeCap = StrokeCap.square;

    canvas.drawLine(Offset(index * this.width, 0),
        Offset(index * this.width, this.value.ceilToDouble()), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
