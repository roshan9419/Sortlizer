import 'package:sorting_visualization/datamodels/algo_history_track.dart';
import 'package:stacked/stacked.dart';

class SortingDetailedViewModel extends BaseViewModel {
  final List<AlgoHistoryTrack> algoTracksList;
  List<bool> _isExpanded = [];

  SortingDetailedViewModel(this.algoTracksList) {
    _isExpanded = List.filled(algoTracksList.length, false);
    print(algoTracksList[0].sortTrack);
  }

  onSeeTrackBtnTap(int index) {
    _isExpanded[index] = !_isExpanded[index];
    notifyListeners();
  }

  bool isItemExpanded(int index) {
    return _isExpanded[index];
  }
}