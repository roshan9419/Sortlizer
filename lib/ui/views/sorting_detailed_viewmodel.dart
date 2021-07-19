import 'package:sorting_visualization/datamodels/algo_history_track.dart';
import 'package:stacked/stacked.dart';

class SortingDetailedViewModel extends BaseViewModel {
  final List<AlgoHistoryTrack> algoTracksList;

  List<HistoryTrack> historyTrackList = [];

  SortingDetailedViewModel(this.algoTracksList) {
    algoTracksList.forEach((element) {
      historyTrackList.add(HistoryTrack(
        isExpanded: false,
        algoTrack: element,
        currentPageCount: element.sortTrack.length > 10 ? 10 : element.sortTrack.length
      ));
    });
  }

  onSeeTrackBtnTap(HistoryTrack item) {
    item.isExpanded = !item.isExpanded;
    item.currentPageCount = item.algoTrack.sortTrack.length > 10 ? 10 : item.algoTrack.sortTrack.length;
    notifyListeners();
  }

  loadMore(HistoryTrack trackItem) {
    trackItem.currentPageCount += 10;
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

  HistoryTrack({this.currentPageCount, this.algoTrack, this.isExpanded = false});
}