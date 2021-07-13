import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sorting_visualization/app/locator.dart';
import 'package:sorting_visualization/datamodels/algorithmType.dart';
import 'package:sorting_visualization/datamodels/dialogType.dart';
import 'package:sorting_visualization/ui/widgets/sorting_history.dart';
import 'package:sorting_visualization/utils/contents.dart';
import 'package:soundpool/soundpool.dart';
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

  double _sortingSpeed = 150;

  double get sortingSpeed => _sortingSpeed;

  int _sortDuration = 0;

  int get sortDuration => _sortDuration;

  int _totalComparisons = 0;

  int get totalComparisons => _totalComparisons;

  double _sliderValue = 0.0;

  double get sliderValue => _sliderValue;

  bool isLoading = true;
  bool isSorting = false;
  bool isContentExpanded = false;
  bool isFirstTime = true;
  bool isSoundEnable = false;

  StreamController<List<int>> _streamController;
  Soundpool _soundpool;
  int _soundId;

  @override
  Future<StreamController<List<int>>> futureToRun() async {
    isLoading = true;
    return new StreamController();
  }

  @override
  void onData(StreamController data) async {
    super.onData(data);
    _streamController = data;
    reset();
    isLoading = false;
    notifyListeners();
    _soundpool = Soundpool(streamType: StreamType.notification);
    _soundId = await rootBundle
        .load("assets/audios/sort_sound.mp3")
        .then((ByteData soundData) {
      return _soundpool.load(soundData);
    });
  }

  playSound() async {
    if (this.isSoundEnable) await _soundpool.play(_soundId);
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  StreamController getStreamController() {
    return _streamController;
  }

  reset({List<int> customNumbers}) {
    if (isSorting) {
      _snackBarService.showSnackbar(
          message: "Sorting in Progress...",
          duration: Duration(milliseconds: 800));
      return;
    }
    _numbers = [];

    if (customNumbers != null && customNumbers.isNotEmpty) {
      customNumbers.forEach((num) {
        _numbers.add(num);
      });
    } else {
      for (int i = 0; i < _sampleSize; ++i) {
        int rndNum = Random().nextInt(_maxNumber.toInt());
        if (rndNum < 10) rndNum += 20; // Just for UI Purpose
        _numbers.add(rndNum);
      }
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

      switch (_algorithmType) {
        case AlgorithmType.BUBBLE_SORT:
          await _bubbleSort();
          break;
        case AlgorithmType.INSERTION_SORT:
          await _insertionSort();
          break;
        case AlgorithmType.SELECTION_SORT:
          await _selectionSort();
          break;
        case AlgorithmType.MERGE_SORT:
          await _mergeSort(0, _sampleSize - 1);
          break;
        case AlgorithmType.QUICK_SORT:
          await _quickSort(0, _sampleSize.toInt() - 1);
          break;
        case AlgorithmType.BOGO_SORT:
          await _bogoSort();
          break;
        case AlgorithmType.CYCLE_SORT:
          await _cycleSort();
          break;
      }

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
      _globalDrawerKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Completed"),
          duration: Duration(milliseconds: 800),
        ),
      );
    }
  }

  updateSpeed(double value) {
    // 200ms, 180ms, 160ms, 140ms, 120ms, 100ms, 80ms, 60ms, 40ms, 20ms, 0ms
    _sliderValue = value;
    _sortingSpeed = 150 - value * 149;
    print('VAL => $value | Speed => $sortingSpeed');
    notifyListeners();
  }

  Duration _getDuration() {
    return Duration(
        milliseconds: _sortingSpeed.toInt()); //speeds[_currentDrnIdx];
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

  /// BUBBLE SORT IMPLEMENTATION
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
        playSound();
        _totalComparisons++;
        await Future.delayed(_getDuration(), () {});

        _chkValueIdx = j;
        _streamController.add(_numbers);
      }
    }
  }

  /// MERGE SORT IMPLEMENTATION
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
        playSound();
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
        playSound();
        await Future.delayed(_getDuration(), () {});
        _streamController.add(_numbers);
      }

      while (j < rightSize) {
        _numbers[k] = rightList[j];
        j++;
        k++;
        _totalComparisons++;

        if (!isSorting) return;
        playSound();
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
      playSound();
      await Future.delayed(_getDuration(), () {});
      _chkValueIdx = middleIndex;
      _totalComparisons++;
      _streamController.add(_numbers);

      await merge(leftIndex, middleIndex, rightIndex);
    }
  }

  /// QUICK SORT IMPLEMENTATION
  _quickSort(int leftIndex, int rightIndex) async {
    Future<int> _partition(int left, int right) async {
      int p = (left + (right - left) / 2).toInt();

      var temp = _numbers[p];
      _numbers[p] = _numbers[right];
      _numbers[right] = temp;

      _chkValueIdx = p;
      if (!isSorting) return -1;
      playSound();
      await Future.delayed(_getDuration(), () {});
      _streamController.add(_numbers);

      int cursor = left;
      for (int i = left; i < right; i++) {
        _totalComparisons++;
        if (compare(_numbers[i], _numbers[right]) <= 0) {
          var temp = _numbers[i];
          _numbers[i] = _numbers[cursor];
          _numbers[cursor] = temp;
          cursor++;

          _chkValueIdx = i;
          if (!isSorting) return -1;
          playSound();
          await Future.delayed(_getDuration(), () {});
          _streamController.add(_numbers);
        }
      }

      temp = _numbers[right];
      _numbers[right] = _numbers[cursor];
      _numbers[cursor] = temp;

      _chkValueIdx = right;
      if (!isSorting) return -1;
      playSound();
      await Future.delayed(_getDuration(), () {});
      _streamController.add(_numbers);

      return cursor;
    }

    if (leftIndex < rightIndex) {
      _totalComparisons++;
      if (!isSorting) return;
      int p = await _partition(leftIndex, rightIndex);
      if (p == -1) return;
      await _quickSort(leftIndex, p - 1);
      await _quickSort(p + 1, rightIndex);
    }
  }

  compare(int a, int b) {
    if (a < b) {
      return -1;
    } else if (a > b) {
      return 1;
    } else {
      return 0;
    }
  }

  /// SELECTION SORT IMPLEMENTATION
  _selectionSort() async {
    mainFlow:
    for (int i = 0; i < _numbers.length; i++) {
      for (int j = i + 1; j < _numbers.length; j++) {
        if (_numbers[i] > _numbers[j]) {
          int temp = _numbers[i];
          _numbers[i] = _numbers[j];
          _numbers[j] = temp;
        }

        if (!isSorting) break mainFlow;
        playSound();
        _totalComparisons++;
        _chkValueIdx = j;
        await Future.delayed(_getDuration());
        _streamController.add(_numbers);
      }
    }
  }

  /// INSERTION SORT IMPLEMENTATION
  _insertionSort() async {
    mainFlow:
    for (int i = 1; i < _numbers.length; i++) {
      int temp = _numbers[i];
      int j = i - 1;
      while (j >= 0 && temp < _numbers[j]) {
        _numbers[j + 1] = _numbers[j];
        j--;

        if (!isSorting) break mainFlow;
        playSound();
        _totalComparisons++;
        _chkValueIdx = j;
        await Future.delayed(_getDuration());
        _streamController.add(_numbers);
      }
      _numbers[j + 1] = temp;
    }
  }

  /// BOGO SORT IMPLEMENTATION
  _bogoSort() async {
    while (!isArraySorted()) {
      _numbers.shuffle();
      if (!isSorting) break;
      playSound();
      _totalComparisons++;
      _chkValueIdx = Random().nextInt(_numbers.length);
      await Future.delayed(_getDuration());
      _streamController.add(_numbers);
    }
  }

  /// CYCLE SORT IMPLEMENTATION
  _cycleSort() async {
    int writes = 0;
    mainFlow:
    for (int cs = 0; cs < _numbers.length - 1; cs++) {
      int item = _numbers[cs];
      int pos = cs;

      for (int i = cs + 1; i < _numbers.length; i++) {
        if (_numbers[i] < item) pos++;

        if (!isSorting) break mainFlow;
        _totalComparisons++;
      }

      if (pos == cs) continue;

      while (item == _numbers[pos]) {
        _totalComparisons++;
        pos += 1;
      }

      if (pos != cs) {
        _totalComparisons++;
        int temp = item;
        item = _numbers[pos];
        _numbers[pos] = temp;
        writes++;
      }

      while (pos != cs) {
        pos = cs;
        for (int i = cs + 1; i < _numbers.length; i++) {
          if (_numbers[i] < item) pos++;

          if (!isSorting) break mainFlow;
          _totalComparisons++;
        }

        while (item == _numbers[pos]) {
          _totalComparisons++;
          pos++;
        }

        if (item != _numbers[pos]) {
          _totalComparisons++;
          int temp = item;
          item = _numbers[pos];
          _numbers[pos] = temp;
          writes++;
        }

        if (!isSorting) break mainFlow;
        playSound();
        _chkValueIdx = pos;
        await Future.delayed(_getDuration());
        _streamController.add(_numbers);
      }
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
    if (isSorting) {
      _snackBarService.showSnackbar(
          message: "Sorting in progress...",
          duration: Duration(milliseconds: 700));
      return;
    }

    var dialogResponse = await _dialogService.showCustomDialog(
        variant: DialogType.CUSTOM_INPUT,
        title: "Provide elements of the Array",
        description: "Example: 23, 45, 98, 67 (Max - $_maxNumber)",
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
          if (num > _maxNumber)
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
              title: "Elements greater than $_maxNumber are not added",
              duration: Duration(milliseconds: 3000))
          : _snackBarService.showSnackbar(message: "Your Array: $inputArray");

      if (inputArray.isNotEmpty) {
        _sampleSize = inputArray.length;
        reset(customNumbers: inputArray);
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

  onSwitchAction(bool value) {
    this.isSoundEnable = value;
    notifyListeners();
  }
}
