import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sorting_visualization/app/locator.dart';
import 'package:sorting_visualization/datamodels/algorithmType.dart';
import 'package:sorting_visualization/datamodels/dialogType.dart';
import 'package:sorting_visualization/ui/widgets/sorting_history.dart';
import 'package:sorting_visualization/utils/contents.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class VisualizerViewModel extends FutureViewModel<StreamController<List<int>>> {
  final _snackBarService = locator<SnackbarService>();
  final _dialogService = locator<DialogService>();
  final _navigationService = locator<NavigationService>();
  final dataContent = DataContent();

  AlgorithmType _algorithmType;

  VisualizerViewModel(this._algorithmType);

  List<int> _numbers = [];

  List<SortHistory> _sortingHistoryList = [];

  GlobalKey<ScaffoldState> _globalDrawerKey = GlobalKey();

  int _chkValueIdx = -1;

  int get checkingValueIdx => _chkValueIdx;

  int _sampleSize = 50;

  int get sampleSize => _sampleSize;

  int _maxNumber = 400;

  int get maxNumber => _maxNumber;

  double _sortingSpeed = 0.0;

  double get sortingSpeed => _sortingSpeed;

  int _sortDuration = 0;

  int get sortDuration => _sortDuration;

  int _totalComparisons = 0;

  int get totalComparisons => _totalComparisons;

  bool isLoading = true;
  bool isSorting = false;
  bool isContentExpanded = false;
  bool isFirstTime = true;

  var _currentDrnIdx = 0;
  List<Duration> speeds = [
    Duration(milliseconds: 50),
    Duration(milliseconds: 30),
    Duration(milliseconds: 20),
    Duration(milliseconds: 10),
    Duration(milliseconds: 5)
  ];

  StreamController<List<int>> _streamController;

  @override
  Future<StreamController<List<int>>> futureToRun() async {
    isLoading = true;
    return new StreamController();
  }

  @override
  void onData(StreamController data) {
    super.onData(data);
    _streamController = data;
    reset();
    isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
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
      int rndNum = Random().nextInt(_maxNumber.toInt());
      if (rndNum < 10) rndNum += 10; // Just for UI Purpose
      _numbers.add(rndNum);
    }

    _streamController.add(_numbers);
    _sortDuration = 0;
    _totalComparisons = 0;
    notifyListeners();
  }

  onActionBtn() async {
    isFirstTime = false;
    if (isArraySorted()) {
      _snackBarService.showSnackbar(message: "Array already sorted!");
      return;
    }
    if (isSorting) {
      isSorting = false;
      notifyListeners();
    } else {
      Stopwatch _stopWatch = new Stopwatch()..start();
      isSorting = true;
      notifyListeners();

      if (_algorithmType == AlgorithmType.BUBBLE_SORT) {
        await _bubbleSort();
      } else if (_algorithmType == AlgorithmType.MERGE_SORT)
        await _mergeSort(0, _sampleSize - 1);

      _stopWatch.stop();
      isSorting = false;
      _sortDuration = _stopWatch.elapsed.inMilliseconds;
      _chkValueIdx = -1;

      _sortingHistoryList.add(SortHistory(
          algoTitle: dataContent.getAlgorithmTitle(_algorithmType),
          arraySize: _sampleSize,
          timeTaken: _sortDuration,
          totalComparisons: _totalComparisons));

      notifyListeners();
      _snackBarService.showSnackbar(
          message: "Completed", duration: Duration(milliseconds: 800));
    }
  }

  updateSpeed(double value) {
    if (value == 0.0) _currentDrnIdx = 0;
    if (value == 0.25) _currentDrnIdx = 1;
    if (value == 0.5) _currentDrnIdx = 2;
    if (value == 0.75) _currentDrnIdx = 3;
    if (value == 1.0) _currentDrnIdx = 4;
    _sortingSpeed = value;
    notifyListeners();
  }

  Duration _getDuration() {
    return speeds[_currentDrnIdx];
  }

  getGlobalKey() {
    return _globalDrawerKey;
  }

  List<int> getNumbers() {
    return _numbers;
  }

  List<SortHistory> getSortingHistoryList() {
    return _sortingHistoryList;
  }

  _bubbleSort() async {
    mainFlow:
    for (int i = 0; i < _numbers.length; ++i) {
      for (int j = 0; j < _numbers.length - i - 1; ++j) {
        if (_numbers[j] > _numbers[j + 1]) {
          int temp = _numbers[j];
          _numbers[j] = _numbers[j + 1];
          _numbers[j + 1] = temp;
        }

        if (!isSorting) break mainFlow;
        _totalComparisons++;
        await Future.delayed(_getDuration(), () {});

        _chkValueIdx = j;
        _streamController.add(_numbers);
      }
    }
  }

  _mergeSort(int leftIndex, int rightIndex) async {
    Future<void> merge(int leftIndex, int middleIndex, int rightIndex) async {
      int leftSize = middleIndex - leftIndex + 1;
      int rightSize = rightIndex - middleIndex;

      List leftList = new List(leftSize);
      List rightList = new List(rightSize);

      for (int i = 0; i < leftSize; i++) leftList[i] = _numbers[leftIndex + i];
      for (int j = 0; j < rightSize; j++)
        rightList[j] = _numbers[middleIndex + j + 1];

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
        _totalComparisons++;

        if (!isSorting) return;
        await Future.delayed(_getDuration(), () {});
        _chkValueIdx = k;
        _streamController.add(_numbers);

        k++;
      }

      while (i < leftSize) {
        _numbers[k] = leftList[i];
        i++;
        k++;
        _totalComparisons++;

        if (!isSorting) return;
        await Future.delayed(_getDuration(), () {});
        _streamController.add(_numbers);
      }

      while (j < rightSize) {
        _numbers[k] = rightList[j];
        j++;
        k++;
        _totalComparisons++;

        if (!isSorting) return;
        await Future.delayed(_getDuration(), () {});
        _chkValueIdx = k;
        _streamController.add(_numbers);
      }
    }

    if (leftIndex < rightIndex) {
      int middleIndex = (rightIndex + leftIndex) ~/ 2;

      await _mergeSort(leftIndex, middleIndex);
      await _mergeSort(middleIndex + 1, rightIndex);

      if (!isSorting) return;
      await Future.delayed(_getDuration(), () {});
      _chkValueIdx = middleIndex;
      _totalComparisons++;
      _streamController.add(_numbers);

      await merge(leftIndex, middleIndex, rightIndex);
    }
  }

  bool isArraySorted() {
    for (int i = 1; i < _numbers.length; i++) {
      if (_numbers[i - 1] > _numbers[i]) return false;
    }
    return true;
  }

  String getTitle() {
    return dataContent.getAlgorithmTitle(_algorithmType);
  }

  String getAlgorithmDesc() {
    return dataContent.getDescription(_algorithmType);
  }

  String getTC(int idx) {
    return dataContent.getTimeComplexities(_algorithmType)[idx];
  }

  String getAlgorithmCode() {
    return dataContent.getAlgorithmCode(_algorithmType);
  }

  onCustomBtnClick() async {
    var dialogResponse = await _dialogService.showCustomDialog(
        variant: DialogType.CUSTOM_INPUT,
        title: "Provide elements of the Array",
        description: "Example: 23, 45, 98, 67 (Max - 500)",
        mainButtonTitle: "Submit",
        secondaryButtonTitle: "Cancel",
        barrierDismissible: false);

    if (dialogResponse != null &&
        dialogResponse.confirmed &&
        dialogResponse.responseData.toString().isNotEmpty) {
      List<String> responseArray =
          dialogResponse.responseData.toString().split(",");
      List<int> inputArray = [];
      bool flag = true;

      responseArray.forEach((element) {
        try {
          var num = int.parse(element.trim());
          if (num > 500)
            flag = false;
          else
            inputArray.add(num);
        } catch (e) {
          flag = false;
        }
      });

      !flag
          ? _snackBarService.showSnackbar(
              message: "Your Array: $inputArray",
              title: "Elements greater than 500 are not added",
              duration: Duration(milliseconds: 3000))
          : _snackBarService.showSnackbar(message: "Your Array: $inputArray");

      if (inputArray.isNotEmpty) {
        _numbers = inputArray;
        _sampleSize = _numbers.length;
        // _numbers.forEach((num) {
        //   if (_maxNumber < num) {
        //     _maxNumber = num;
        //   }
        // });
        notifyListeners();
      }
    }
  }

  onBackBtnPressed() {
    _navigationService.back();
  }

  List<String> getAlgorithmsList() {
    return dataContent.getAlgorithms();
  }

  onMenuItemClick(String value) {
    if (isSorting) {
      // _snackBarService.showSnackbar(message: "To change Algorithm Stop Sorting");
    } else {
      _algorithmType = dataContent.getAlgorithmType(value);
    }
    notifyListeners();
  }

  openMenuDrawer() {
    _globalDrawerKey.currentState.openEndDrawer();
  }

  changeArraySize() async {
    if (isSorting) {
      _snackBarService.showSnackbar(
          message: "Sorting in progress...",
          duration: Duration(milliseconds: 700));
      return;
    }
    var dialogResponse = await _dialogService.showCustomDialog(
        variant: DialogType.CUSTOM_ARRAY_SIZE,
        title: "Provide size of the Array",
        description: "1 < Input < 1000",
        mainButtonTitle: "Submit",
        secondaryButtonTitle: "Cancel",
        barrierDismissible: false);

    if (dialogResponse != null &&
        dialogResponse.confirmed &&
        dialogResponse.responseData.toString().isNotEmpty) {
      _sampleSize = int.parse(dialogResponse.responseData.toString());
      reset();
    }
  }
}
