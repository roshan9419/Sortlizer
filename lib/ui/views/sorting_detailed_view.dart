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
          style: Theme.of(context)
              .textTheme
              .caption
              .copyWith(color: lightGrayColor, fontFamily: 'Arial', fontWeight: FontWeight.bold)),
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
                border: Border.all(color: lightGrayColor)),
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
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                              )
                          )
                      ),
                      onPressed: () => model.onSeeTrackBtnTap(),
                      child: Text('See Track', style: theme.textTheme.caption.copyWith(color: Colors.white)),
                    ),
                  )
                ])
              ],
            ),
          );
        });
  }
}
