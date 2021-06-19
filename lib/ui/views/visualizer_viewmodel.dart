import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:sorting_visualization/app/locator.dart';
import 'package:sorting_visualization/datamodels/algorithmType.dart';
import 'package:sorting_visualization/utils/contents.dart';
import 'package:sorting_visualization/utils/sorting_color_schemes.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class VisualizerViewModel extends FutureViewModel<StreamController<List<int>>> {
  VisualizerViewModel(this._algorithmType);

  final _snackBarService = locator<SnackbarService>();


  AlgorithmType _algorithmType;

  List<int> _numbers = [];
  StreamController<List<int>> _streamController;

  double _sampleSize = 200;
  double maxNumber = 400;

  bool isLoading = true;
  bool isSorting = false;

  var currentColorScheme = 0;
  List<Color> colorScheme = [];

  var currentDrnIdx = 0;
  List<Duration> speeds = [
    Duration(microseconds: 2500),
    Duration(microseconds: 2000),
    Duration(microseconds: 1500),
    Duration(microseconds: 1000),
    Duration(microseconds: 500),
    Duration(microseconds: 200),
    Duration(microseconds: 50)
  ];

  @override
  Future<StreamController<List<int>>> futureToRun() async {
    isLoading = true;
    return new StreamController();
  }

  @override
  void onData(StreamController data) {
    super.onData(data);
    _streamController = data;
    colorScheme = SortingColorScheme().getRandomColorScheme();
    reset();
    isLoading = false;
    notifyListeners();
  }

  StreamController getStreamController() {
    return _streamController;
  }

  reset() {
    if (isSorting) {
      _snackBarService.showSnackbar(message: "Sorting in Progress...");
      return;
    }
    _numbers = [];
    for (int i = 0; i < _sampleSize; ++i) {
      _numbers.add(Random().nextInt(maxNumber.toInt()));
    }
    _streamController.add(_numbers);
  }

  updateSpeed() {
    currentDrnIdx == speeds.length - 1 ? currentDrnIdx = 0 : currentDrnIdx++;
    notifyListeners();
  }

  play() async {
    isSorting = true;
    if (_algorithmType == AlgorithmType.BUBBLE_SORT) await _bubbleSort();
    else if (_algorithmType == AlgorithmType.MERGE_SORT) await _mergeSort(0, _sampleSize.toInt() - 1);
    _snackBarService.showSnackbar(message: "Completed");
  }

  Duration _getDuration() {
    return speeds[currentDrnIdx];
  }

  changeSortingTheme() {
    colorScheme = SortingColorScheme().getRandomColorScheme();
    _streamController.add(_numbers);
  }

  List<int> getNumbers() {
    return _numbers;
  }

  double getSampleSize() {
    return _sampleSize;
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  _bubbleSort() async {
    for (int i = 0; i < _numbers.length; ++i) {
      for (int j = 0; j < _numbers.length - i - 1; ++j) {
        if (_numbers[j] > _numbers[j + 1]) {
          int temp = _numbers[j];
          _numbers[j] = _numbers[j + 1];
          _numbers[j + 1] = temp;
        }

        await Future.delayed(_getDuration(), () {});

        _streamController.add(_numbers);
      }
    }
    isSorting = false;
  }

  _mergeSort(int leftIndex, int rightIndex) async {
    Future<void> merge(int leftIndex, int middleIndex, int rightIndex) async {
      int leftSize = middleIndex - leftIndex + 1;
      int rightSize = rightIndex - middleIndex;

      List leftList = new List(leftSize);
      List rightList = new List(rightSize);

      for (int i = 0; i < leftSize; i++) leftList[i] = _numbers[leftIndex + i];
      for (int j = 0; j < rightSize; j++) rightList[j] = _numbers[middleIndex + j + 1];

      int i = 0, j = 0;
      int k = leftIndex;

      while (i < leftSize && j < rightSize) {
        if (leftList[i] <= rightList[j]) {
          _numbers[k] = leftList[i];
          i++;
        } else {
          _numbers[k] = rightList[j];
          j++;
        }

        await Future.delayed(_getDuration(), () {});
        _streamController.add(_numbers);

        k++;
      }

      while (i < leftSize) {
        _numbers[k] = leftList[i];
        i++;
        k++;

        await Future.delayed(_getDuration(), () {});
        _streamController.add(_numbers);
      }

      while (j < rightSize) {
        _numbers[k] = rightList[j];
        j++;
        k++;

        await Future.delayed(_getDuration(), () {});
        _streamController.add(_numbers);
      }
      isSorting = false;
    }

    if (leftIndex < rightIndex) {
      int middleIndex = (rightIndex + leftIndex) ~/ 2;

      await _mergeSort(leftIndex, middleIndex);
      await _mergeSort(middleIndex + 1, rightIndex);

      await Future.delayed(_getDuration(), () {});

      _streamController.add(_numbers);

      await merge(leftIndex, middleIndex, rightIndex);
    }
  }

  String getTitle() {
    return DataContent().getAlgorithmTitle(_algorithmType);
  }

  String getAlgorithmDesc() {
    return DataContent().getDescription(_algorithmType);
  }

  String getTC(int idx) {
    return DataContent().getTimeComplexities(_algorithmType)[idx];
  }
}
