import 'package:sorting_visualization/app/locator.dart';
import 'package:sorting_visualization/app/router.gr.dart';
import 'package:sorting_visualization/datamodels/algorithmType.dart';
import 'package:sorting_visualization/datamodels/dialogType.dart';
import 'package:sorting_visualization/services/shared_preference_service.dart';
import 'package:sorting_visualization/utils/contents.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final _sharedPrefService = locator<SharedPreferenceService>();

  HomeViewModel();

  getAlgorithmsList() {
    return DataContent().getAlgorithms();
  }

  String getAppVersion() {
    // Need to use package
    return "Version: 1.0.12";
  }

  moveToVisualizerView() async {
    AlgorithmType _algoType = _sharedPrefService.algorithmSelected != null
        ? getAlgoTypeFromString(_sharedPrefService.algorithmSelected)
        : AlgorithmType.BUBBLE_SORT;
    await _navigationService.navigateTo(Routes.visualizerView,
        arguments: VisualizerViewArguments(algorithmType: _algoType));
  }

  showAboutApp() async {
    var desc = "Use this Sorting Visualizer to understand and visualize different sorting algorithms like, Bubble Sort, Merge Sort, Quick Sort, Radix Sort and many more...\n\n" +
        "Visualize your own custom input array, see the step-by-step sorting history of the algorithm.\n\n" +
        "It is an open-source project, find the repository from my GitHub account.";

    await _dialogService.showCustomDialog(
        variant: DialogType.ABOUT_APP,
        title: "About",
        description: desc,
        barrierDismissible: true);
  }
}
