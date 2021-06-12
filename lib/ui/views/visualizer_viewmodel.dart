import 'dart:async';
import 'dart:math';

import 'package:sorting_visualization/datamodels/algorithmType.dart';
import 'package:stacked/stacked.dart';

class VisualizerViewModel extends BaseViewModel {
  VisualizerViewModel(this._algorithmType);

  AlgorithmType _algorithmType;

  List<int> _numbers = [];
  StreamController<List<int>> _streamController = StreamController();

  double _sampleSize = 320;

  Map<String, AlgorithmType> algorithmsMap = {
    "Bubble Sort": AlgorithmType.BUBBLE_SORT,
    "Insertion Sort": AlgorithmType.INSERTION_SORT,
    "Selection Sort": AlgorithmType.SELECTION_SORT,
    "Merge Sort": AlgorithmType.MERGE_SORT,
    "Quick Sort": AlgorithmType.QUICK_SORT
  };

  reset() {
    _numbers = [];
    for (int i = 0; i < _sampleSize; ++i) {
      _numbers.add(Random().nextInt(500));
    }
    _streamController.add(_numbers);
    // notifyListeners();
  }

  String getTitle() {
    switch (_algorithmType) {
      case AlgorithmType.BUBBLE_SORT:
        return "Bubble Sort";
      case AlgorithmType.INSERTION_SORT:
        return "Insertion Sort";
      case AlgorithmType.SELECTION_SORT:
        return "Selection Sort";
      case AlgorithmType.MERGE_SORT:
        return "Merge Sort";
      case AlgorithmType.QUICK_SORT:
        return "Quick Sort";
      default: return "Sorting Visualiser";
    }
  }
}
