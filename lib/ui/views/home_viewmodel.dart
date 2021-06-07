import 'package:sorting_visualization/ui/app/locator.dart';
import 'package:sorting_visualization/ui/app/router.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  HomeViewModel();

  String selectedAlgorithm = "Merge Sort";

  moveToVisualizerView() async {
    await _navigationService.navigateTo(Routes.visualizerView,
        arguments: VisualizerViewArguments(algorithmTitle: selectedAlgorithm));
  }
}
