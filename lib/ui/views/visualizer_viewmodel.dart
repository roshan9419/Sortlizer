import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sorting_visualization/app/locator.dart';
import 'package:sorting_visualization/app/router.gr.dart';
import 'package:sorting_visualization/datamodels/algo_history_track.dart';
import 'package:sorting_visualization/datamodels/algorithmType.dart';
import 'package:sorting_visualization/datamodels/dialogType.dart';
import 'package:sorting_visualization/services/shared_preference_service.dart';
import 'package:sorting_visualization/utils/contents.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class VisualizerViewModel extends FutureViewModel<StreamController<List<int>>> {
  final _snackBarService = locator<SnackbarService>();
  final _dialogService = locator<DialogService>();
  final _navigationService = locator<NavigationService>();
  final _sharedPrefService = locator<SharedPreferenceService>();
  final dataContent = DataContent();

  AlgorithmType _algorithmType;

  VisualizerViewModel(this._algorithmType, Size size) {
    double x = size.height * 0.22; // bottomSheetHeight
    double y = 100; //header height
    _maxNumber = (size.height - x - y).toInt();
    if (_maxNumber > 500) {
      _maxNumber = 500;
    }
    print(_maxNumber);
  }

  List<int> _numbers = [];

  List<AlgoHistoryTrack> _algoHistoryTrackList = [];
  List<List<int>> _currentAlgoSortRecords = new List();

  GlobalKey<ScaffoldState> _globalDrawerKey = GlobalKey();

  int _chkValueIdx = -1;

  int get checkingValueIdx => _chkValueIdx;

  int _sampleSize = 50;

  int get sampleSize => _sampleSize;

  int _maxNumber;

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
  bool isShowHistoryEnable = true;
  bool flagMode = true;
  bool hideChakra = true;

  StreamController<List<int>> _streamController;

  // Soundpool _soundpool;
  // int _soundId;

  @override
  Future<StreamController<List<int>>> futureToRun() async {
    isLoading = true;
    return new StreamController();
  }

  @override
  void onData(StreamController data) async {
    super.onData(data);
    _streamController = data;

    // Initializing last saved settings
    _sampleSize = _sharedPrefService.sortingArraySize;
    _sliderValue = _sharedPrefService.sortingSliderValue;
    isShowHistoryEnable = _sharedPrefService.showSortingHistory;
    updateSpeed(_sliderValue);

    reset();
    isLoading = false;
    notifyListeners();
    /*_soundpool = Soundpool(streamType: StreamType.notification);
    _soundId = await rootBundle
        .load("assets/audios/sort_sound.mp3")
        .then((ByteData soundData) {
      return _soundpool.load(soundData);
    });*/
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
    hideChakra = true;

    if (customNumbers != null && customNumbers.isNotEmpty) {
      customNumbers.forEach((num) {
        _numbers.add(num);
      });
    } else {
      for (int i = 0; i < _sampleSize; ++i) {
        int rndNum = Random().nextInt(_maxNumber.toInt());
        if (rndNum < 10) rndNum += 50; // Just for UI Purpose
        _numbers.add(flagMode ? i : rndNum);
      }
      if (flagMode) _numbers.shuffle();
    }

    _streamController.add(_numbers);
    _sortDuration = 0;
    _totalComparisons = 0;
    _currentAlgoSortRecords = new List();
    notifyListeners();
  }

  onActionBtn() async {
    isFirstTime = false;
    if (isArraySorted()) {
      _snackBarService.showSnackbar(message: "Array already sorted!");
      return;
    }
    if (isSorting) {
      print('FORCED STOP');
      isSorting = false;
      hideChakra = true;
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
        case AlgorithmType.RADIX_SORT:
          await _radixSort();
          break;
        case AlgorithmType.COCKTAIL_SORT:
          await _cocktailSort();
          break;
        case AlgorithmType.ODD_EVEN_SORT:
          await _oddEvenSort();
          break;
        case AlgorithmType.HEAP_SORT:
          await _heapSort();
          break;
        case AlgorithmType.SHELL_SORT:
          await _shellSort();
          break;
        case AlgorithmType.BEAD_SORT:
          await _beadSort();
          break;
        case AlgorithmType.GNOME_SORT:
          await _gnomeSort();
          break;
      }

      _stopWatch.stop();
      isSorting = false;
      hideChakra = !isArraySorted();
      _sortDuration = _stopWatch.elapsed.inMilliseconds;
      _chkValueIdx = -1;

      saveCurrentSortingStep();
      _algoHistoryTrackList.add(AlgoHistoryTrack(
          algoTitle: dataContent.getAlgorithmTitle(_algorithmType),
          arraySize: _sampleSize,
          timeTaken: _sortDuration,
          totalComparisons: _totalComparisons,
          sortTrack: _currentAlgoSortRecords));

      notifyListeners();
      /*_globalDrawerKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Completed"),
          duration: Duration(milliseconds: 800),
        ),
      );*/
    }
  }

  // callable from inside function
  onSortInBTCall({bool tCTU = true, int chkIdx = 0}) async {
    if (tCTU) {
      _totalComparisons++;
    }
    _chkValueIdx = chkIdx;
    await Future.delayed(_getDuration(), () {});
    _streamController.add(_numbers);
  }

  // Saving sortingStep
  saveCurrentSortingStep() {
    List<int> tempList = [];
    _numbers.forEach((num) {
      tempList.add(num);
    });
    _currentAlgoSortRecords.add(tempList);
  }

  updateSpeed(double value) {
    // 200ms, 180ms, 160ms, 140ms, 120ms, 100ms, 80ms, 60ms, 40ms, 20ms, 0ms
    _sliderValue = value;
    _sharedPrefService.sortingSliderValue = _sliderValue;
    _sortingSpeed = 150 - _sliderValue * 149;
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

  List<AlgoHistoryTrack> getSortingHistoryList() {
    return _algoHistoryTrackList;
  }

  /// BUBBLE SORT IMPLEMENTATION
  _bubbleSort() async {
    mainFlow:
    for (int i = 0; i < _numbers.length; ++i) {
      bool swapped = false;
      for (int j = 0; j < _numbers.length - i - 1; ++j) {
        saveCurrentSortingStep();
        if (_numbers[j] > _numbers[j + 1]) {
          int temp = _numbers[j];
          _numbers[j] = _numbers[j + 1];
          _numbers[j + 1] = temp;
          swapped = true;
        }

        if (!isSorting) break mainFlow;
        await onSortInBTCall(chkIdx: j);
      }
      if (!swapped) break;
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
        saveCurrentSortingStep();

        if (leftList[i] <= rightList[j]) {
          _numbers[k] = leftList[i];
          i++;
        } else {
          _numbers[k] = rightList[j];
          j++;
        }

        if (!isSorting) return;
        await onSortInBTCall(chkIdx: k);

        k++;
      }

      while (i < leftSize) {
        saveCurrentSortingStep();
        _numbers[k] = leftList[i];
        i++;
        k++;

        if (!isSorting) return;
        await onSortInBTCall(chkIdx: k);
      }

      while (j < rightSize) {
        saveCurrentSortingStep();
        _numbers[k] = rightList[j];
        j++;
        k++;

        if (!isSorting) return;
        await onSortInBTCall(chkIdx: k);
      }
    }

    if (leftIndex < rightIndex) {
      int middleIndex = (rightIndex + leftIndex) ~/ 2;

      await _mergeSort(leftIndex, middleIndex);
      await _mergeSort(middleIndex + 1, rightIndex);

      if (!isSorting) return;
      await onSortInBTCall(chkIdx: middleIndex);

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

      if (!isSorting) return -1;
      await onSortInBTCall(chkIdx: p, tCTU: false);
      saveCurrentSortingStep();

      int cursor = left;
      for (int i = left; i < right; i++) {
        _totalComparisons++;
        if (compare(_numbers[i], _numbers[right]) <= 0) {
          var temp = _numbers[i];
          _numbers[i] = _numbers[cursor];
          _numbers[cursor] = temp;
          cursor++;

          if (!isSorting) return -1;
          await onSortInBTCall(chkIdx: i, tCTU: false);
        }
        saveCurrentSortingStep();
      }

      temp = _numbers[right];
      _numbers[right] = _numbers[cursor];
      _numbers[cursor] = temp;

      if (!isSorting) return -1;
      await onSortInBTCall(chkIdx: right, tCTU: false);
      saveCurrentSortingStep();

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
        saveCurrentSortingStep();
        if (_numbers[i] > _numbers[j]) {
          int temp = _numbers[i];
          _numbers[i] = _numbers[j];
          _numbers[j] = temp;
        }

        if (!isSorting) break mainFlow;
        await onSortInBTCall(chkIdx: j);
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
        saveCurrentSortingStep();
        _numbers[j + 1] = _numbers[j];
        j--;

        if (!isSorting) break mainFlow;
        await onSortInBTCall(chkIdx: j);
      }
      _numbers[j + 1] = temp;
      saveCurrentSortingStep();
    }
  }

  /// BOGO SORT IMPLEMENTATION
  _bogoSort() async {
    saveCurrentSortingStep();
    while (!isArraySorted()) {
      _numbers.shuffle();
      if (!isSorting) break;
      await onSortInBTCall(chkIdx: Random().nextInt(_numbers.length));
      saveCurrentSortingStep();
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
        saveCurrentSortingStep();
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
          saveCurrentSortingStep();
        }

        if (!isSorting) break mainFlow;
        await onSortInBTCall(chkIdx: pos, tCTU: false);
      }
    }
  }

  /// RADIX SORT IMPLEMENTATION
  _radixSort() async {
    Future<int> getMax() async {
      int mx = _numbers[0];
      for (int i = 0; i < _numbers.length; i++) {
        mx = max(_numbers[i], mx);
      }
      return mx;
    }

    saveCurrentSortingStep();
    Future<void> countingSort(int place) async {
      int max = 10;
      List<int> output = new List(_numbers.length);
      List<int> count = new List(max);

      for (int i = 0; i < max; i++) count[i] = 0;

      for (int i = 0; i < _numbers.length; i++) {
        count[_numbers[i] ~/ place % max]++;
        if (!isSorting) return;
        // await onSortInBTCall(chkIdx: i, tCTU: false);
      }

      for (int i = 1; i < max; i++) {
        count[i] += count[i - 1];
        if (!isSorting) return;
        // await onSortInBTCall(chkIdx: i, tCTU: false);
      }

      for (int i = _numbers.length - 1; i >= 0; i--) {
        output[count[_numbers[i] ~/ place % max] - 1] = _numbers[i];
        count[_numbers[i] ~/ place % max]--;
        if (!isSorting) return;
        // await onSortInBTCall(chkIdx: i, tCTU: false);
      }

      for (int i = 0; i < _numbers.length; i++) {
        _numbers[i] = output[i];
        if (!isSorting) return;
        await onSortInBTCall(chkIdx: i, tCTU: false);
        saveCurrentSortingStep();
      }
    }

    int _max = await getMax();
    for (int place = 1; _max ~/ place > 0; place *= 10) {
      await countingSort(place);
      // print(place);
      if (!isSorting) return;
      await onSortInBTCall(chkIdx: -1, tCTU: false);
    }
  }

  /// COCKTAIL SORT IMPLEMENTATION
  _cocktailSort() async {
    bool isSwapped = true;
    int start = 0;
    int end = _numbers.length;

    while (isSwapped) {
      isSwapped = false;

      for (int i = start; i < end - 1; i++) {
        if (_numbers[i] > _numbers[i + 1]) {
          int temp = _numbers[i];
          _numbers[i] = _numbers[i + 1];
          _numbers[i + 1] = temp;
          isSwapped = true;
        }

        if (!isSorting) return;
        await onSortInBTCall(chkIdx: i);
        saveCurrentSortingStep();
      }

      if (!isSwapped) break;

      isSwapped = false;
      end = end - 1;
      for (int i = end - 1; i >= start; i--) {
        if (_numbers[i] > _numbers[i + 1]) {
          int temp = _numbers[i];
          _numbers[i] = _numbers[i + 1];
          _numbers[i + 1] = temp;
          isSwapped = true;
        }

        if (!isSorting) return;
        await onSortInBTCall(chkIdx: i);
        saveCurrentSortingStep();
      }

      start = start + 1;
    }
  }

  /// ODD EVEN SORT IMPLEMENTATION
  _oddEvenSort() async {
    bool isSorted = false;

    while (!isSorted) {
      isSorted = true;

      for (int i = 1; i <= _numbers.length - 2; i += 2) {
        if (_numbers[i] > _numbers[i + 1]) {
          int temp = _numbers[i];
          _numbers[i] = _numbers[i + 1];
          _numbers[i + 1] = temp;
          isSorted = false;
        }
        if (!isSorting) return;
        await onSortInBTCall(chkIdx: i);
        saveCurrentSortingStep();
      }

      for (int i = 0; i <= _numbers.length - 2; i += 2) {
        if (_numbers[i] > _numbers[i + 1]) {
          int temp = _numbers[i];
          _numbers[i] = _numbers[i + 1];
          _numbers[i + 1] = temp;
          isSorted = false;
        }

        if (!isSorting) return;
        await onSortInBTCall(chkIdx: i);
        saveCurrentSortingStep();
      }
    }
  }

  /// HEAP SORT IMPLEMENTATION
  _heapSort() async {
    for (int i = _numbers.length ~/ 2; i >= 0; i--) {
      if (!isSorting) return;
      await heapify(_numbers, _numbers.length, i);
    }
    for (int i = _numbers.length - 1; i >= 0; i--) {
      int temp = _numbers[0];
      _numbers[0] = _numbers[i];
      _numbers[i] = temp;
      if (!isSorting) return;
      await heapify(_numbers, i, 0);
    }
  }

  heapify(List<int> arr, int n, int i) async {
    int largest = i;
    int l = 2 * i + 1;
    int r = 2 * i + 2;

    if (l < n && arr[l] > arr[largest]) largest = l;
    _totalComparisons++;
    if (r < n && arr[r] > arr[largest]) largest = r;
    _totalComparisons++;

    if (largest != i) {
      int temp = _numbers[i];
      _numbers[i] = _numbers[largest];
      _numbers[largest] = temp;
      heapify(arr, n, largest);
    }

    await onSortInBTCall(chkIdx: i);
    saveCurrentSortingStep();
  }

  /// SHELL SORT IMPLEMENTATION
  _shellSort() async {
    mainFlow:
    for (int gap = _numbers.length ~/ 2; gap > 0; gap ~/= 2) {
      for (int i = gap; i < _numbers.length; i++) {
        int temp = _numbers[i];
        int j;
        for (j = i; j >= gap && _numbers[j - gap] > temp; j -= gap) {
          _numbers[j] = _numbers[j - gap];
          _totalComparisons++;
          saveCurrentSortingStep();
        }

        _numbers[j] = temp;
        saveCurrentSortingStep();
        if (!isSorting) break mainFlow;
        await onSortInBTCall(chkIdx: j, tCTU: false);
      }
    }
  }

  /// BEAD SORT IMPLEMENTATION
  _beadSort() async {
    int _max = _numbers[0];
    for (int i = 0; i < _numbers.length; i++) {
      _max = max(_numbers[i], _max);
    }

    // setting the abacus
    List grid = List.generate(
        _numbers.length, (index) => new List.filled(_max, BeadStatus.NULL),
        growable: false);

    List<int> levelCount = [];
    for (int i = 0; i < _max; i++) {
      levelCount.add(0);
      for (int j = 0; j < _numbers.length; j++) {
        grid[j][i] = BeadStatus.NOT_MARKED;
      }
    }

    for (int i = 0; i < _numbers.length; i++) {
      var num = _numbers[i];
      for (int j = 0; num > 0; j++, num--) {
        grid[levelCount[j]++][j] = BeadStatus.MARKED;
      }
    }

    for (int i = 0; i < _numbers.length; i++) {
      int putt = 0;
      for (int j = 0;
          j < _max && grid[_numbers.length - 1 - i][j] == BeadStatus.MARKED;
          j++) {
        putt++;
        _totalComparisons++;
      }
      _numbers[i] = putt;
      saveCurrentSortingStep();
      if (!isSorting) return;
      await onSortInBTCall(chkIdx: i, tCTU: false);
    }
  }

  /// GNOME SORT IMPLEMENTATION
  _gnomeSort() async {
    int index = 0;
    while (index < _numbers.length) {
      if (index == 0) index++;
      if (_numbers[index] >= _numbers[index - 1])
        index++;
      else {
        int temp = _numbers[index];
        _numbers[index] = _numbers[index - 1];
        _numbers[index - 1] = temp;

        index--;
      }
      saveCurrentSortingStep();
      if (!isSorting) return;
      await onSortInBTCall(chkIdx: index);
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

  String getSC() {
    return dataContent.getSpaceComplexity(_algorithmType);
  }

  String getExtraInfo() {
    return dataContent.algoExtraInfo(_algorithmType);
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
        description:
            "Example: ${Random().nextInt(100)}, ${Random().nextInt(100)}, ${Random().nextInt(100)}, ${Random().nextInt(100)} (Max - ${(_maxNumber ~/ 10) * 10})",
        mainButtonTitle: "Submit",
        secondaryButtonTitle: "Cancel",
        customData: (_maxNumber ~/ 10) * 10,
        barrierDismissible: false);

    if (dialogResponse != null &&
        dialogResponse.confirmed &&
        dialogResponse.responseData != null) {
      List<int> responseArray = dialogResponse.responseData.toList();

      if (responseArray.isNotEmpty) {
        _sampleSize = responseArray.length;
        reset(customNumbers: responseArray);
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
      _sharedPrefService.algorithmSelected = _algorithmType.toString();
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
      _sharedPrefService.sortingArraySize = _sampleSize;
      reset();
    }
  }

  onShowHistorySwitchAction(bool value) {
    // this.isSoundEnable = value;
    this.isShowHistoryEnable = value;
    _sharedPrefService.showSortingHistory = value;
    notifyListeners();
  }

  onShowFlagSwitchAction(bool value) {
    if (!isSorting) {
      this.flagMode = value;
    }
    reset();
    notifyListeners();
  }

  moveToDetailedSortHistory() {
    _navigationService.navigateTo(Routes.sortingDetailedView,
        arguments:
            SortingDetailedViewArguments(algoTracks: _algoHistoryTrackList));
  }
}

enum BeadStatus { MARKED, NOT_MARKED, NULL }
