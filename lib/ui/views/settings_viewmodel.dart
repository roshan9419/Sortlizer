import 'package:flutter/scheduler.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sorting_visualization/app/locator.dart';
import 'package:sorting_visualization/app/router.router.dart';
import 'package:sorting_visualization/datamodels/barType.dart';
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
  final _snackBarService = locator<SnackbarService>();

  late PackageInfo packageInfo;

  bool get showSortingHistory => _sharedPrefService.showSortingHistory;

  bool get sortingSoundsEnabled => _sharedPrefService.sortingSoundEnabled;

  BarType get selectedBarType => _sharedPrefService.barType;

  bool get flagMode => _sharedPrefService.flagMode;

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

  String convertBarTypeToString(BarType type) {
    List<String> parts = getBarTypeName(type).toLowerCase().split("_");
    for (int i = 0; i < parts.length; i++) {
      parts[i] = parts[i].substring(0, 1).toUpperCase() + parts[i].substring(1);
    }
    return parts.join(" ");
  }

  updateBarType() async {

    List<String> options = [];
    BarType.values.forEach((type) {
      options.add(convertBarTypeToString(type));
    });

    DialogResponse? response = await _dialogService.showCustomDialog(
        variant: DialogType.OPTIONS,
        title: "Bars Type",
        description: "Select the type of bar",
        mainButtonTitle: "Submit",
        secondaryButtonTitle: "Cancel",
        data: {
          "options": options,
          "selected": convertBarTypeToString(_sharedPrefService.barType)
        },
        barrierDismissible: true);

    if (response != null && response.data != null) {
      if (flagMode) {
        _snackBarService.showSnackbar(message: "No effect will happen when flag mode is enabled");
        return;
      }
      _sharedPrefService.barType = getBarTypeFromString((response.data as String).replaceAll(" ", "_").toUpperCase());
      notifyListeners();
    }
  }

  updateFlagMode(bool value) {
    _sharedPrefService.flagMode = value;
    notifyListeners();
  }

  resetApp() async {
    await _sharedPrefService.clearData();
    _navigationService.clearStackAndShow(Routes.onBoardingView);
  }

  showSourceCode() async {
    await canLaunchUrl(Uri.parse(readMeLink))
        ? await launchUrl(Uri.parse(readMeLink), mode: LaunchMode.externalApplication)
        : SnackbarService().showSnackbar(message: "Could not load Url");
  }

  onBackBtnPressed() {
    _navigationService.back();
  }
}
