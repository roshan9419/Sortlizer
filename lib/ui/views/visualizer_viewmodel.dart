import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:sorting_visualization/datamodels/algorithmType.dart';
import 'package:sorting_visualization/utils/contents.dart';
import 'package:sorting_visualization/utils/sorting_color_schemes.dart';
import 'package:stacked/stacked.dart';

class VisualizerViewModel extends FutureViewModel<StreamController<List<int>>> {
  VisualizerViewModel(this._algorithmType);

  AlgorithmType _algorithmType;

  List<int> _numbers = [];
  StreamController<List<int>> _streamController;

  double _sampleSize = 200;
  double maxNumber = 400;

  int _duration = 100;

  bool isLoading = true;

  List<Color> colorScheme = [];

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

  reset() {
    _numbers = [];
    for (int i = 0; i < _sampleSize; ++i) {
      _numbers.add(Random().nextInt(maxNumber.toInt()));
    }
    _streamController.add(_numbers);
    notifyListeners();
  }

  play() {
    _bubbleSort();
  }

  updateSpeed() {
    colorScheme = SortingColorScheme().getRandomColorScheme();
    notifyListeners();
  }

  List<int> getNumbers() {
    return _numbers;
  }

  double getSampleSize() {
    return _sampleSize;
  }

  StreamController getStreamController() {
    return _streamController;
  }

  Duration _getDuration() {
    return Duration(microseconds: _duration);
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
