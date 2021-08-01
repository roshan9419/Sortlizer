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
        builder: (context, model, child) =>
            Container(
              decoration: BoxDecoration(
                  gradient: darkGradient),
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
          style: Theme
              .of(context)
              .textTheme
              .caption
              .copyWith(
              color: lightGrayColor,
              fontFamily: 'Arial',
              fontWeight: FontWeight.bold)),
      SizedBox(height: 5),
      Text(value.toString(),
          style: Theme
              .of(context)
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
          HistoryTrack item = model.historyTrackList[index];
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
                  item.algoTrack.algoTitle,
                  style: theme.textTheme.subtitle1.copyWith(
                      color: Colors.white,
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Row(children: [
                  _getItemInfo("Array Size", item.algoTrack.arraySize, context),
                  SizedBox(width: 10),
                  _getItemInfo(
                      "Time Taken(ms)", item.algoTrack.timeTaken, context),
                  SizedBox(width: 10),
                  _getItemInfo(
                      "Comparisons", item.algoTrack.totalComparisons, context),
                  Spacer(),
                  Container(
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: item.isExpanded
                          ? orangeThemeColor
                          : theme.primaryColor,
                    ),
                    child: TextButton(
                      onPressed: () => model.onSeeTrackBtnTap(item),
                      child: Text(item.isExpanded ? 'Hide' : 'See Track',
                          style: theme.textTheme.caption
                              .copyWith(color: Colors.white)),
                    ),
                  )
                ]),
                if (item.isExpanded) _StepByStepHistoryList(trackItem: item)
              ],
            ),
          );
        });
  }
}

class _StepByStepHistoryList extends ViewModelWidget<SortingDetailedViewModel> {
  final HistoryTrack trackItem;

  const _StepByStepHistoryList({Key key, this.trackItem}) : super(key: key);

  List<Widget> _buildCells({List<int> numbers,
    bool isIndexes = false,
    Color indexColor = Colors.white,
    bool isHighlightRow = false}) {
    return List.generate(
      numbers.length,
          (index) =>
          Container(
            alignment: Alignment.center,
            width: 30,
            height: 20,
            color: isHighlightRow ? Color(0xff25282D) : darkBackgroundStart,
            child: Text(
              numbers[index].toString(),
              style: TextStyle(
                  color: isIndexes ? indexColor : Colors.white,
                  fontSize: 10),
            ),
          ),
    );
  }

  List<Widget> _buildRows() {
    return List.generate(
      trackItem.currentPageCount, //trackItem.algoTrack.sortTrack.length,
          (index) {
        print('Index: $index');
        return Row(
          children: _buildCells(
              numbers: trackItem.algoTrack.sortTrack[index],
              isHighlightRow: index % 2 == 0),
        );
      },
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

  _buildRows2() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: trackItem.algoTrack.sortTrack.length,
      itemBuilder: (context, index) {
        return Row(
            children: _buildCells(
                numbers: trackItem.algoTrack.sortTrack[index],
                isHighlightRow: index % 2 == 0));
      },
    );
  }*/

  List<int> getList() {
    List<int> temp = [];
    for (int i = 0; i < trackItem.currentPageCount; i++)
      temp.add(i);
    return temp;
  }

  @override
  Widget build(BuildContext context, SortingDetailedViewModel model) {
    return Container(
        margin: const EdgeInsets.only(top: 10),
        // constraints: BoxConstraints(maxHeight: 600),
        child: trackItem.algoTrack.sortTrack.isNotEmpty &&
            trackItem.algoTrack.arraySize > 200
            ? Text(
          'Array Size is too large to visualize. Use array size of 200 or less.',
          style: Theme
              .of(context)
              .textTheme
              .subtitle2
              .copyWith(color: orangeThemeColor),
        )
            : trackItem.algoTrack.sortTrack.isNotEmpty
            ? SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _buildCells(
                        numbers: getList(),
                        isIndexes: true,
                        indexColor: Theme.of(context).primaryColor,
                        isHighlightRow: false),
                  ),
                  Flexible(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _buildRows(),
                        ),
                      ))
                ],
              ),
              if (trackItem.currentPageCount <
                  trackItem.algoTrack.sortTrack.length)
                TextButton(
                    onPressed: () => model.loadMore(trackItem),
                    child: Text('Load more', style: TextStyle(color: Theme.of(context).primaryColor),))
            ],
          ),
        )
            : Text('Nothing Found', style: Theme.of(context).textTheme.caption
            .copyWith(color: Colors.white)));
  }
}
