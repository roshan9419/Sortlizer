import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sorting_visualization/datamodels/algo_history_track.dart';
import 'package:sorting_visualization/ui/views/sorting_detailed_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../ui_theme.dart';

class SortingDetailedView extends StatelessWidget {
  final List<AlgoHistoryTrack> algoTracks;

  const SortingDetailedView({Key key, this.algoTracks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SortingDetailedViewModel>.reactive(
        builder: (context, model, child) => Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      tileMode: TileMode.clamp,
                      colors: [darkBackgroundStart, darkBackgroundFinish])),
              child: SafeArea(
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: _BodyView(),
                ),
              ),
            ),
        viewModelBuilder: () => SortingDetailedViewModel(algoTracks));
  }
}

class _BodyView extends ViewModelWidget<SortingDetailedViewModel> {
  _BodyView({Key key}) : super(key: key, reactive: true);

  Widget _getItemInfo(String title, int value, BuildContext context) {
    var theme = Theme.of(context);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title,
          style: Theme.of(context).textTheme.caption.copyWith(
              color: lightGrayColor,
              fontFamily: 'Arial',
              fontWeight: FontWeight.bold)),
      SizedBox(height: 5),
      Text(value.toString(),
          style: Theme.of(context)
              .textTheme
              .overline
              .copyWith(color: lightGrayColor, fontFamily: 'Arial')),
    ]);
  }

  @override
  Widget build(BuildContext context, SortingDetailedViewModel model) {
    var theme = Theme.of(context);

    return ListView.builder(
        itemCount: model.algoTracksList.length,
        itemBuilder: (child, index) {
          AlgoHistoryTrack item = model.algoTracksList[index];
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                border: Border.all(color: mediumGrayColor)),
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  item.algoTitle,
                  style: theme.textTheme.subtitle1.copyWith(
                      color: Colors.white,
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Row(children: [
                  _getItemInfo("Array Size", item.arraySize, context),
                  SizedBox(width: 10),
                  _getItemInfo("Time Taken(ms)", item.timeTaken, context),
                  SizedBox(width: 10),
                  _getItemInfo("Comparisons", item.totalComparisons, context),
                  Spacer(),
                  Container(
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: model.isItemExpanded(index)
                          ? orangeThemeColor
                          : theme.primaryColor,
                    ),
                    child: TextButton(
                      onPressed: () => model.onSeeTrackBtnTap(index),
                      child: Text(
                          model.isItemExpanded(index) ? 'Hide' : 'See Track',
                          style: theme.textTheme.caption
                              .copyWith(color: Colors.white)),
                    ),
                  )
                ]),
                if (model.isItemExpanded(index))
                  _StepByStepHistoryList(numbersTrack: item.sortTrack)
              ],
            ),
          );
        });
  }
}

class _StepByStepHistoryList extends StatelessWidget {
  final List<List<int>> numbersTrack;

  const _StepByStepHistoryList({Key key, this.numbersTrack}) : super(key: key);

  List<Widget> _buildCells(
      {List<int> numbers,
      bool isIndexes = false,
      bool isHighlightRow = false}) {
    return List.generate(
      numbers.length,
      (index) => Container(
        alignment: Alignment.center,
        width: 30,
        height: 20,
        color: isHighlightRow ? Color(0xff25282D) : darkBackgroundStart,
        child: Text(
          numbers[index].toString(),
          style: TextStyle(
              color: isIndexes ? Colors.deepPurpleAccent : Colors.white,
              fontSize: 10),
        ),
      ),
    );
  }

  List<Widget> _buildRows() {
    return List.generate(
      numbersTrack.length,
          (index) => Row(
        children: _buildCells(numbers: numbersTrack[index], isHighlightRow: index%2==0),
      ),
    );
  }

 /* _buildCells(
      {List<int> numbers,
      bool isIndexes = false,
      bool isHighlightRow = false}) {
    return ListView.builder(
      itemCount: numbers.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Container(
          alignment: Alignment.center,
          width: 30,
          height: 20,
          color: isHighlightRow ? Color(0xff25282D) : darkBackgroundStart,
          child: Text(
            numbers[index].toString(),
            style: TextStyle(
                color: isIndexes ? Colors.deepPurpleAccent : Colors.white,
                fontSize: 10),
          ),
        );
      },
    );
  }

  _buildRows() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        return _buildCells(
            numbers: numbersTrack[index], isHighlightRow: index % 2 == 0);
      },
      itemCount: numbersTrack.length,
    );
  }*/

  List<int> getList() {
    List<int> temp = [];
    for (int i = 0; i < numbersTrack.length; i++) temp.add(i);
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 10),
        // constraints: BoxConstraints(maxHeight: 600),
        child: SingleChildScrollView(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _buildCells(
                    numbers: getList(), isIndexes: true, isHighlightRow: false),
              ),
              Flexible(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _buildRows(),
                  ),
                ),
              )
            ],
          ),
        ));

    // return Container(
    //     margin: const EdgeInsets.only(top: 10),
    //     height: 100,
    //     // constraints: BoxConstraints(maxHeight: 600),
    //     child: _buildRows()//_buildCells(numbers: getList())
    // );
  }
}
