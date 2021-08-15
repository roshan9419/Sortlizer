import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sorting_visualization/datamodels/algorithmType.dart';
import 'package:sorting_visualization/ui/ui_theme.dart';
import 'package:sorting_visualization/ui/views/visualizer_viewmodel.dart';
import 'package:sorting_visualization/ui/widgets/ashok_chakra.dart';
import 'package:sorting_visualization/ui/widgets/bar_painter.dart';
import 'package:sorting_visualization/ui/widgets/bars_loader.dart';
import 'package:sorting_visualization/ui/widgets/code_viewer.dart';
import 'package:sorting_visualization/ui/widgets/menu_drawer.dart';
import 'package:sorting_visualization/ui/widgets/custom_round_btn.dart';
import 'package:sorting_visualization/ui/widgets/sorting_history.dart';
import 'package:stacked/stacked.dart';

class VisualizerView extends StatelessWidget {
  final AlgorithmType algorithmType;

  const VisualizerView({this.algorithmType, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VisualizerViewModel>.reactive(
      builder: (context, model, child) => Container(
        decoration: BoxDecoration(gradient: darkGradient),
        child: Scaffold(
          key: model.getGlobalKey(),
          resizeToAvoidBottomPadding: false,
          endDrawer: MenuDrawer(
              menuItemsList: model.getAlgorithmsList(),
              selectedValue: model.getTitle(),
              onTap: model.onMenuItemClick,
              isSwitchEnable: model.isShowHistoryEnable,
              flagMode: model.flagMode,
              onSwitchAction: model.onShowHistorySwitchAction,
              onShowFlagSwitchAction: model.onShowFlagSwitchAction),
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              _HeaderView(),
              !model.isLoading
                  ? Positioned(
                      bottom: MediaQuery.of(context).size.height * 0.22 - 10,
                      child: _VisualizerContainerWidget())
                  : SizedBox.shrink(),
              if (!model.hideChakra && model.flagMode) Center(child: AshokChakra()),
              BuildBottomDraggableSheet()
            ],
          ),
        ),
      ),
      viewModelBuilder: () =>
          VisualizerViewModel(algorithmType, MediaQuery.of(context).size),
    );
  }
}

class _HeaderView extends ViewModelWidget<VisualizerViewModel> {
  _HeaderView({Key key}) : super(key: key, reactive: true);

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
                CustomRoundButton(
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
                CustomRoundButton(
                  icon: Icon(
                    Icons.menu,
                    color: lightGrayColor,
                    size: 18,
                  ),
                  btnColor: darkBtnColor2,
                  onTap: model.openMenuDrawer,
                )
              ],
            ),
          ),
          if (!model.isFirstTime)
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(model.isSorting ? 'Sorting' : 'Sort Result',
                    style: theme.textTheme.overline
                        .copyWith(color: mediumGrayColor, letterSpacing: 0.5)),
                SizedBox(height: 2),
                model.isSorting
                    ? MyBarLoader()
                    : Text(
                        '${model.sortDuration} ms, ${model.totalComparisons} Comparisons',
                        style: theme.textTheme.caption.copyWith(
                            color: lightGrayColor, letterSpacing: 0.5),
                      )
                // MyStopWatch(
                //   onGoing: true,
                // )
              ],
            ),
          // Spacer(),
          // !model.isLoading ? _VisualizerContainerWidget() : SizedBox.shrink(),
          // SizedBox(
          //   height: 200,
          // )
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
      initialChildSize: 0.22,
      minChildSize: 0.22,
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
                /*Container(
                  width: 50,
                  height: 1,
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                      color: lightGrayColor,
                      borderRadius: BorderRadius.circular(5)),
                ),*/
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
                      value: model.sliderValue,
                      divisions: 10,
                      activeColor: Theme.of(context).primaryColor,
                      onChanged: (val) {
                        model.updateSpeed(val);
                      }),
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomRoundButton(
                        icon: Icon(
                          Icons.edit_road_rounded,
                          color: lightGrayColor,
                        ),
                        btnSize: 50,
                        labelText: "Custom",
                        onTap: model.onCustomBtnClick),
                    CustomRoundButton(
                      icon: Icon(
                        Icons.bar_chart_sharp,
                        color: lightGrayColor,
                      ),
                      btnSize: 50,
                      labelText: "Size",
                      onTap: model.changeArraySize,
                    ),
                    CustomRoundButton(
                      icon: Icon(
                        Icons.refresh,
                        color: lightGrayColor,
                      ),
                      btnSize: 50,
                      labelText: "Reset",
                      onTap: model.reset,
                    ),
                    CustomRoundButton(
                      icon: model.isSorting
                          ? Icon(
                              Icons.stop,
                              color: Colors.white,
                            )
                          : Icon(
                              Icons.play_arrow_rounded,
                              color: Colors.white,
                            ),
                      btnSize: 50,
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
                if (model.getSortingHistoryList().isNotEmpty &&
                    model.isShowHistoryEnable)
                  SortingHistoryTable(
                    itemsList: model.getSortingHistoryList(),
                    tableName: "Sorting History",
                    onDetailsBtnTap: model.moveToDetailedSortHistory,
                  ),
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Time Complexity:",
                    style: theme.textTheme.caption
                        .copyWith(color: mediumGrayColor),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        "Worst Case:\t",
                        style: theme.textTheme.subtitle2.copyWith(
                            fontFamily: 'Arial',
                            fontWeight: FontWeight.normal,
                            color: Colors.white70),
                      ),
                      Text(model.getTC(0),
                          style: theme.textTheme.subtitle2.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1)),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Average Case:\t",
                        style: theme.textTheme.subtitle2.copyWith(
                            fontFamily: 'Arial',
                            fontWeight: FontWeight.normal,
                            color: Colors.white70),
                      ),
                      Text(model.getTC(1),
                          style: theme.textTheme.subtitle2.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1)),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Best Case:\t",
                        style: theme.textTheme.subtitle2.copyWith(
                            fontFamily: 'Arial',
                            fontWeight: FontWeight.normal,
                            color: Colors.white70),
                      ),
                      Text(model.getTC(2),
                          style: theme.textTheme.subtitle2.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1)),
                    ],
                  ),
                ],
              ),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Space Complexity:",
                    style: theme.textTheme.caption
                        .copyWith(color: mediumGrayColor),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        "Worst Case:\t",
                        style: theme.textTheme.subtitle2.copyWith(
                            fontFamily: 'Arial',
                            fontWeight: FontWeight.normal,
                            color: Colors.white70),
                      ),
                      Text(model.getSC(),
                          style: theme.textTheme.subtitle2.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1)),
                    ],
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 20),
          if (model.getExtraInfo().isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text(
                model.getExtraInfo(),
                style: theme.textTheme.subtitle2
                    .copyWith(color: lightGrayColor, fontFamily: 'Arial'),
              ),
            ),
          if (model.getAlgorithmCode().isNotEmpty)
            CodeViewer(
              codeContent: model.getAlgorithmCode(),
              titleLabel: "C++",
            )
        ],
      ),
    );
  }
}

class _VisualizerContainerWidget extends ViewModelWidget<VisualizerViewModel> {
  @override
  Widget build(BuildContext context, VisualizerViewModel model) {
    return Container(
      child: StreamBuilder<Object>(
          initialData: model.getNumbers(),
          stream: model.getStreamController().stream,
          builder: (context, snapshot) {
            List<int> numbers = snapshot.data;
            int counter = 0;

            var division =
                (MediaQuery.of(context).size.width.toInt() / model.sampleSize);

            return Row(
              children: numbers.map((int num) {
                counter++;
                return Container(
                  height: model.maxNumber.toDouble(),
                  child: Padding(
                    padding: EdgeInsets.only(right: division * 0.5),
                    child: CustomPaint(
                        painter: BarPainter(
                            index: counter,
                            value: num,
                            maxValue: model.maxNumber,
                            checkingValueIdx: model.checkingValueIdx,
                            width: division * 0.5,
                            barColor: Theme.of(context).primaryColor,
                            arraySize: model.sampleSize,
                            flagMode: model.flagMode)),
                  ),
                );
              }).toList(),
            );
          }),
    );
  }
}
