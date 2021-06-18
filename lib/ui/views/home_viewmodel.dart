import 'package:sorting_visualization/app/locator.dart';
import 'package:sorting_visualization/app/router.gr.dart';
import 'file:///F:/Flutter_Projects/sorting_visualization/lib/utils/contents.dart';
import 'package:sorting_visualization/datamodels/algorithmType.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  HomeViewModel();

  getAlgorithmsList() {
    return DataContent().getAlgorithms();
  }

  moveToVisualizerView() async {
    await _navigationService.navigateTo(Routes.visualizerView,
        arguments: VisualizerViewArguments(algorithmType: AlgorithmType.MERGE_SORT));
  }
}
