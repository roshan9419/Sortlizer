import 'package:flutter/services.dart';
import 'package:share/share.dart';
import 'package:sorting_visualization/app/locator.dart';
import 'package:sorting_visualization/app/router.router.dart';
import 'package:sorting_visualization/datamodels/algorithmType.dart';
import 'package:sorting_visualization/datamodels/dialogType.dart';
import 'package:sorting_visualization/services/shared_preference_service.dart';
import 'package:sorting_visualization/utils/app_info.dart';
import 'package:sorting_visualization/utils/contents.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final _sharedPrefService = locator<SharedPreferenceService>();

  HomeViewModel();

  getAlgorithmsList() {
    return DataContent().getAlgorithms();
  }

  moveToVisualizerView() async {
    AlgorithmType _algoType = _sharedPrefService.algorithmSelected != null
        ? getAlgoTypeFromString(_sharedPrefService.algorithmSelected!)
        : AlgorithmType.BUBBLE_SORT;
    await _navigationService.navigateTo(Routes.visualizerView,
        arguments: VisualizerViewArguments(algorithmType: _algoType));
  }

  void showAboutApp() async {
    var desc = "Use this Sortlizer (Sorting Visualizer) to understand and visualize different sorting algorithms like Bubble Sort, Merge Sort, Quick Sort, Radix Sort, and many more...\n\n" +
        "Visualize your custom input array. See the step-by-step sorting history of the algorithm.\n\n" +
        "Easily understand how the sorting algorithms differ in terms of size, space, and time";

    await _dialogService.showCustomDialog(
        variant: DialogType.ABOUT_APP,
        title: "About",
        description: desc,
        barrierDismissible: true);
  }

  void onShareBtnTap() async {
    var appUrl = "https://play.google.com/store/apps/details?id=" + packageName;
    var message =
        "Try out this amazing Sorting Visualizer app on PlayStore!\n\n$appUrl";

    Share.share(message, subject: "Share to");
  }

  void onReviewBtnTap() async {
    try {
      // launch("market://details?id=" + packageName);
      launchUrl(Uri.parse(
          "https://play.google.com/store/apps/details?id=" + packageName), mode: LaunchMode.externalApplication);
    } on PlatformException catch (_) {
      launchUrl(Uri.parse(
          "https://play.google.com/store/apps/details?id=" + packageName), mode: LaunchMode.externalApplication);
    } finally {
      launchUrl(Uri.parse(
          "https://play.google.com/store/apps/details?id=" + packageName), mode: LaunchMode.externalApplication);
    }
  }
}
