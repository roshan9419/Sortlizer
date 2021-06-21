import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:sorting_visualization/app/locator.dart';
import 'package:sorting_visualization/datamodels/algorithmType.dart';
import 'package:sorting_visualization/datamodels/bottomSheetType.dart';
import 'package:sorting_visualization/utils/contents.dart';
import 'package:sorting_visualization/utils/sorting_color_schemes.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class VisualizerViewModel extends FutureViewModel<StreamController<List<int>>> {
  VisualizerViewModel(this._algorithmType);

  final _snackBarService = locator<SnackbarService>();
  final _bottomSheetService = locator<BottomSheetService>();

  AlgorithmType _algorithmType;

  List<int> _numbers = [];
  StreamController<List<int>> _streamController;

  double _sampleSize = 80;
  double maxNumber = 400;

  bool isLoading = true;
  bool isSorting = false;

  var currentColorScheme = 0;
  List<Color> colorScheme = [];

  var currentDrnIdx = 0;
  List<Duration> speeds = [
    Duration(microseconds: 1600),
    Duration(microseconds: 1300),
    Duration(microseconds: 1000),
    Duration(microseconds: 700),
    Duration(microseconds: 400),
    Duration(microseconds: 100),
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

  onActionBtn() async {
    if (isArraySorted()) {
      _snackBarService.showSnackbar(message: "Array already sorted!");
      return;
    }
    if (isSorting) {
      isSorting = false;
    } else {
      isSorting = true;
      notifyListeners();
      if (_algorithmType == AlgorithmType.BUBBLE_SORT)
        await _bubbleSort();
      else if (_algorithmType == AlgorithmType.MERGE_SORT)
        await _mergeSort(0, _sampleSize.toInt() - 1);

      isSorting = false;
      _snackBarService.showSnackbar(message: "Completed");
      notifyListeners();
    }
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
        if (!isSorting) break;
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

  bool isArraySorted() {
    for (int i = 1; i < _numbers.length; i++) {
      if (_numbers[i - 1] > _numbers[i]) return false;
    }
    return true;
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

  String getAlgorithmCode() {
    return DataContent().getAlgorithmCode(_algorithmType);
  }

  onCustomBtnClick() async {
    var sheetResponse = await _bottomSheetService.showCustomSheet(
        variant: BottomSheetType.CUSTOM_ARRAY,
        title: 'Enter the elements of array:',
        description: 'Example: 23, 45, 98, 67',
        barrierDismissible: true);

    if (sheetResponse != null &&
        sheetResponse.confirmed &&
        sheetResponse.responseData.toString().isNotEmpty) {
      print('CONFIRMED' + sheetResponse.responseData);

      List<String> responseArray =
          sheetResponse.responseData.toString().split(",");
      List<int> inputArray = [];
      bool flag = true;

      responseArray.forEach((element) {
        try {
          var num = int.parse(element.trim());
          inputArray.add(num);
        } catch (e) {
          flag = false;
        }
      });

      !flag
          ? _snackBarService.showSnackbar(message: "Invalid numbers")
          : _snackBarService.showSnackbar(message: "Your Array: $inputArray");

      if (flag) {
        _numbers = inputArray;
        _sampleSize = inputArray.length.toDouble();
      }
    }
  }

  String _exampleCode =
      "class MyHomePage extends StatefulWidget { MyHomePage({Key key, this.title}) : super(key: key); final String title; @override _MyHomePageState createState() => _MyHomePageState();}";
}
