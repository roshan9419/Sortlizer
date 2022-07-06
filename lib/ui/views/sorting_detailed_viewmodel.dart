import 'package:sorting_visualization/datamodels/algo_history_track.dart';
import 'package:stacked/stacked.dart';

class SortingDetailedViewModel extends BaseViewModel {
  final List<AlgoHistoryTrack> algoTracksList;

  List<HistoryTrack> historyTrackList = [];

  int step = 20;

  SortingDetailedViewModel(this.algoTracksList) {
    algoTracksList.forEach((element) {
      historyTrackList.add(HistoryTrack(
          isExpanded: false,
          algoTrack: element,
          currentPageCount: element.sortTrack.length > step
              ? step
              : element.sortTrack.length));
    });
  }

  onSeeTrackBtnTap(HistoryTrack item) {
    item.isExpanded = !item.isExpanded;
    item.currentPageCount = item.algoTrack.sortTrack.length > step
        ? step
        : item.algoTrack.sortTrack.length;
    notifyListeners();
  }

  loadMore(HistoryTrack trackItem) {
    trackItem.currentPageCount += step;
    if (trackItem.currentPageCount > trackItem.algoTrack.sortTrack.length) {
      trackItem.currentPageCount = trackItem.algoTrack.sortTrack.length;
    }
    notifyListeners();
    print('Loaded');
  }
}

class HistoryTrack {
  int currentPageCount;
  bool isExpanded;
  AlgoHistoryTrack algoTrack;

  HistoryTrack(
      {required this.currentPageCount,
      required this.algoTrack,
      this.isExpanded = false});
}
