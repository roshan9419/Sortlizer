import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sorting_visualization/datamodels/algorithmType.dart';
import 'package:sorting_visualization/ui/ui_theme.dart';
import 'package:sorting_visualization/ui/views/visualizer_viewmodel.dart';
import 'package:sorting_visualization/ui/widgets/code_viewer.dart';
import 'package:sorting_visualization/ui/widgets/neumorphic_round_btn.dart';
import 'package:stacked/stacked.dart';

class VisualizerView extends StatelessWidget {
  final AlgorithmType algorithmType;

  const VisualizerView({this.algorithmType, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VisualizerViewModel>.reactive(
      builder: (context, model, child) => Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                tileMode: TileMode.clamp,
                colors: [darkBackgroundStart, darkBackgroundFinish])),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [_VisualizerScreen(), BuildBottomDraggableSheet()],
          ),
        ),
      ),
      viewModelBuilder: () => VisualizerViewModel(algorithmType),
    );
  }
}

class _VisualizerScreen extends ViewModelWidget<VisualizerViewModel> {
  _VisualizerScreen({Key key}) : super(key: key, reactive: true);

  @override
  Widget build(BuildContext context, VisualizerViewModel model) {
    var theme = Theme.of(context);
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 15, bottom: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NeumorphicButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: lightGrayColor,
                    size: 18,
                  ),
                  btnColor: darkBtnColor2,
                  onTap: model.onBackBtnPressed,
                ),
                Text(
                  model.getTitle(),
                  style: theme.textTheme.subtitle2
                      .copyWith(color: Colors.white, fontSize: 15),
                ),
                NeumorphicButton(
                    icon: Icon(
                      Icons.menu,
                      color: lightGrayColor,
                      size: 18,
                    ),
                    btnColor: darkBtnColor2,
                  onTap: model.changeSortingAlgorithm,
                )
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Time',
                  style: theme.textTheme.overline
                      .copyWith(color: mediumGrayColor, letterSpacing: 0.5)),
              Text(
                '0ms',
                style: theme.textTheme.caption
                    .copyWith(color: lightGrayColor, letterSpacing: 0.5),
              )
            ],
          ),
          Spacer(),
          !model.isLoading ? _VisualizerContainerWidget() : SizedBox.shrink(),
          SizedBox(
            height: 150,
          )
        ],
      ),
    );
  }
}

class BuildBottomDraggableSheet extends ViewModelWidget<VisualizerViewModel> {
  @override
  Widget build(BuildContext context, VisualizerViewModel model) {
    return _buildBottomCommandCenter(context, model);
  }

  Widget _buildBottomCommandCenter(
      BuildContext context, VisualizerViewModel model) {
    return DraggableScrollableSheet(
      initialChildSize: !model.isContentExpanded ? 0.23 : 0.9,
      minChildSize: 0.23,
      expand: true,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: BoxDecoration(
              color: darkBackgroundFinish,
              boxShadow: [
                BoxShadow(
                    color: Color(0xf727272),
                    blurRadius: 15,
                    offset: Offset(0, -5))
              ],
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            physics: BouncingScrollPhysics(),
            controller: scrollController,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (int i = 1; i <= 5; i++)
                          Text(
                            '${i}x',
                            style: Theme.of(context)
                                .textTheme
                                .overline
                                .copyWith(color: lightGrayColor),
                          ),
                      ]),
                ),
                Container(
                  height: 30,
                  child: Slider(
                      value: model.sortingSpeed,
                      divisions: 4,
                      onChanged: (val) {
                        print('Value Changed: $val');
                        model.updateSpeed(val);
                      }),
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    NeumorphicButton(
                        icon: Icon(
                          Icons.edit_road_rounded,
                          color: lightGrayColor,
                        ),
                        btnSize: 46,
                        labelText: "Custom",
                        onTap: model.onCustomBtnClick),
                    NeumorphicButton(
                      icon: Icon(
                        Icons.info_outline,
                        color: lightGrayColor,
                      ),
                      btnSize: 46,
                      labelText: "Info",
                      onTap: model.expandContentSheet,
                    ),
                    NeumorphicButton(
                      icon: Icon(
                        Icons.refresh,
                        color: lightGrayColor,
                      ),
                      btnSize: 46,
                      labelText: "Reset",
                      onTap: model.reset,
                    ),
                    NeumorphicButton(
                      icon: model.isSorting
                          ? Icon(
                              Icons.stop,
                              color: Colors.white,
                            )
                          : Icon(
                              Icons.play_arrow_rounded,
                              color: Colors.white,
                            ),
                      btnSize: 46,
                      labelText: model.isSorting ? "Stop" : "Start",
                      btnColor: model.isSorting
                          ? Colors.red
                          : Theme.of(context).primaryColor,
                      onTap: model.onActionBtn,
                      isPressed: true,
                    )
                  ],
                ),
                SizedBox(height: 30),
                _buildAlgorithmContent(context, model),
              ],
            ),
          ),
        );
      },
    );
  }

  _buildAlgorithmContent(BuildContext context, VisualizerViewModel model) {
    var theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text(
            model.getTitle(),
            style: theme.textTheme.subtitle1.copyWith(
                color: theme.primaryColor, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            model.getAlgorithmDesc(),
            style: theme.textTheme.subtitle2
                .copyWith(color: lightGrayColor, fontFamily: 'Arial'),
          ),
          SizedBox(height: 25),
          Text(
            "Time Complexity:",
            style: theme.textTheme.caption.copyWith(color: mediumGrayColor),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Text(
                "Worst Case:\t",
                style: theme.textTheme.subtitle2.copyWith(
                    fontFamily: 'Arial', fontWeight: FontWeight.normal, color: Colors.white70),
              ),
              Text(model.getTC(0),
                  style: theme.textTheme.subtitle2
                      .copyWith(fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1)),
            ],
          ),
          Row(
            children: [
              Text(
                "Average Case:\t",
                style: theme.textTheme.subtitle2.copyWith(
                    fontFamily: 'Arial', fontWeight: FontWeight.normal, color: Colors.white70),
              ),
              Text(model.getTC(1),
                  style: theme.textTheme.subtitle2
                      .copyWith(fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1)),
            ],
          ),
          Row(
            children: [
              Text(
                "Best Case:\t",
                style: theme.textTheme.subtitle2.copyWith(
                    fontFamily: 'Arial', fontWeight: FontWeight.normal, color: Colors.white70),
              ),
              Text(model.getTC(2),
                  style: theme.textTheme.subtitle2
                      .copyWith(fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1)),
            ],
          ),
          SizedBox(height: 20),
          CodeViewer(codeContent: model.getAlgorithmCode(), titleLabel: "C++", sourceLabel: "GeeksForGeeks",)
        ],
      ),
    );
  }
}

class _VisualizerContainerWidget extends ViewModelWidget<VisualizerViewModel> {
  @override
  Widget build(BuildContext context, VisualizerViewModel model) {
    return Container(
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
                  child: Padding(
                    padding: EdgeInsets.only(right: 2),
                    child: CustomPaint(
                      painter: BarPainter(
                          index: counter,
                          value: num,
                          checkingValue: model.checkingValue,
                          colorScheme: model.colorScheme,
                          width: MediaQuery.of(context).size.width /
                              model.getSampleSize()),
                    ),
                  ),
                );
              }).toList(),
            );
          }),
    );
  }
}

class BarPainter extends CustomPainter {
  final double width;
  final int value;
  final int checkingValue;
  final double maxValue;
  final int index;
  final List<Color> colorScheme;

  BarPainter(
      {this.width,
      this.value,
      this.checkingValue,
      this.maxValue,
      this.index,
      this.colorScheme});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = (checkingValue != -1 && value == checkingValue)
        ? Colors.red
        : blueThemeColor;

    paint.strokeWidth = width;
    paint.strokeCap = StrokeCap.round;

    var pt1 = Offset(index * this.width, 400 - this.value.ceilToDouble());
    // var pt2 = Offset(index * this.width, this.value.ceilToDouble());
    var pt2 = Offset(index * this.width, 400);

    canvas.drawLine(pt1, pt2, paint); // TODO - NEED TO WORK
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
