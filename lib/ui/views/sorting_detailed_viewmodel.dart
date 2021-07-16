import 'package:sorting_visualization/datamodels/algo_history_track.dart';
import 'package:stacked/stacked.dart';

class SortingDetailedViewModel extends BaseViewModel {
  final List<AlgoHistoryTrack> algoTracksList;

  SortingDetailedViewModel(this.algoTracksList);

  onSeeTrackBtnTap() {
    print('HO');
  }
}