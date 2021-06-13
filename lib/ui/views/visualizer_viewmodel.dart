import 'dart:async';
import 'dart:math';

import 'package:sorting_visualization/data/contents.dart';
import 'package:sorting_visualization/datamodels/algorithmType.dart';
import 'package:stacked/stacked.dart';

class VisualizerViewModel extends FutureViewModel<StreamController<List<int>>> {
  VisualizerViewModel(this._algorithmType);

  AlgorithmType _algorithmType;

  List<int> _numbers = [];
  StreamController<List<int>> _streamController;

  double _sampleSize = 100;
  double maxNumber = 300;

  bool isLoading = true;

  reset() {
    _numbers = [];
    for (int i = 0; i < _sampleSize; ++i) {
      _numbers.add(Random().nextInt(maxNumber.toInt()));
    }
    _streamController.add(_numbers);
    notifyListeners();
  }

  play() {
    print('PLAYED');
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
    return Duration(microseconds: 1500);
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
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
}
