import 'package:flutter/scheduler.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sorting_visualization/app/locator.dart';
import 'package:sorting_visualization/app/router.router.dart';
import 'package:sorting_visualization/datamodels/dialogType.dart';
import 'package:sorting_visualization/services/shared_preference_service.dart';
import 'package:sorting_visualization/utils/app_info.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsViewModel extends BaseViewModel implements Initialisable {
  final _navigationService = locator<NavigationService>();
  final _sharedPrefService = locator<SharedPreferenceService>();
  final _dialogService = locator<DialogService>();

  late PackageInfo packageInfo;

  bool get showSortingHistory => _sharedPrefService.showSortingHistory;

  bool get sortingSoundsEnabled => _sharedPrefService.sortingSoundEnabled;

  String get appVersion => packageInfo.version;

  void initialise() {
    setBusy(true);
    setInitialised(true);
  }

  void getInitialized() async {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      packageInfo = await PackageInfo.fromPlatform();
      setBusy(false);
    });
  }

  updateShowSortingHistory(bool value) {
    _sharedPrefService.showSortingHistory = value;
    notifyListeners();
  }

  updateSortingSounds() async {
    DialogResponse? response = await _dialogService.showCustomDialog(
        variant: DialogType.CONFIRMATION,
        title: "Enable Sorting sound?",
        description: "Beep sounds will be played during sorting",
        mainButtonTitle: "Enable",
        secondaryButtonTitle: "Disable",
        barrierDismissible: true);

    if (response != null) {
      _sharedPrefService.sortingSoundEnabled = response.confirmed;
      notifyListeners();
    }
  }

  resetApp() async {
    await _sharedPrefService.clearData();
    _navigationService.clearStackAndShow(Routes.onBoardingView);
  }

  showSourceCode() async {
    await canLaunchUrl(Uri.parse(readMeLink))
        ? await launchUrl(Uri.parse(readMeLink))
        : SnackbarService().showSnackbar(message: "Could not load Url");
  }

  onBackBtnPressed() {
    _navigationService.back();
  }
}
