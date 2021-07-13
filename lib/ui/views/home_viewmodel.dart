import 'package:sorting_visualization/app/locator.dart';
import 'package:sorting_visualization/app/router.gr.dart';
import 'package:sorting_visualization/datamodels/algorithmType.dart';
import 'package:sorting_visualization/utils/contents.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  HomeViewModel();

  getAlgorithmsList() {
    return DataContent().getAlgorithms();
  }

  String getAppVersion() {
    // Need to use package
    return "Version: 1.0.12";
  }

  moveToVisualizerView() async {
    await _navigationService.navigateTo(Routes.visualizerView,
        arguments: VisualizerViewArguments(algorithmType: AlgorithmType.BUBBLE_SORT));
  }
}
