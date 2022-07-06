import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sorting_visualization/services/shared_preference_service.dart';
import 'package:sorting_visualization/setup_bottom_sheet.dart';
import 'package:sorting_visualization/setup_dialogs.dart';
import 'package:sorting_visualization/setup_snackbar_ui.dart';
import 'package:sorting_visualization/ui/theme_setup.dart';
import 'package:sorting_visualization/ui/ui_theme.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked_themes/stacked_themes.dart';

import 'app/locator.dart';
import 'app/router.router.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  setupDialogUi();
  setupBottomSheetUI();
  setupSnackBarUi();
  await ThemeManager.initialise();
  final SharedPreferenceService _sharedPrefService =
      locator<SharedPreferenceService>();
  await _sharedPrefService.initialise();

  runApp(MyApp());
  var style =
      SystemUiOverlayStyle(systemNavigationBarColor: darkBackgroundFinish);
  SystemChrome.setSystemUIOverlayStyle(style);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MyApp extends StatelessWidget {
  final _sharedPrefService = locator<SharedPreferenceService>();

  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
        themes: getThemes(),
        builder: (context, regularTheme, darkTheme, themeMode) => MaterialApp(
              theme: regularTheme,
              debugShowCheckedModeBanner: false,
              darkTheme: darkTheme,
              themeMode: themeMode,
              title: 'Sortlizer',
              initialRoute: _getStartupRoute(),
              onGenerateRoute: StackedRouter().onGenerateRoute,
              navigatorKey: StackedService.navigatorKey,
            ));
  }

  String _getStartupRoute() {
    if (!_sharedPrefService.homeVisible) {
      return Routes.onBoardingView;
    } else {
      return Routes.homeView;
    }
  }
}
