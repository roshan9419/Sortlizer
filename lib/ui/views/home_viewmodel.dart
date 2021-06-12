import 'package:sorting_visualization/app/locator.dart';
import 'package:sorting_visualization/app/router.gr.dart';
import 'package:sorting_visualization/datamodels/algorithmType.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  HomeViewModel();

  String _selectedAlgorithm;

  Map<String, AlgorithmType> algorithmsMap = {
    "Bubble Sort" : AlgorithmType.BUBBLE_SORT,
    "Insertion Sort" : AlgorithmType.INSERTION_SORT,
    "Selection Sort" : AlgorithmType.SELECTION_SORT,
    "Merge Sort" : AlgorithmType.MERGE_SORT,
    "Quick Sort" : AlgorithmType.QUICK_SORT
  };

  getSelectedAlgorithm() {
    if (_selectedAlgorithm == null) _selectedAlgorithm = "Bubble Sort";
    return _selectedAlgorithm;
  }

  getAlgorithmsList() {
    return algorithmsMap.keys.toList();
  }

  updateSelection(String value) {
    _selectedAlgorithm = value;
  }

  moveToVisualizerView() async {
    await _navigationService.navigateTo(Routes.visualizerView,
        arguments: VisualizerViewArguments(algorithmType: algorithmsMap[_selectedAlgorithm]));
  }
}
