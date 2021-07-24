import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sorting_visualization/services/shared_preference_service.dart';
import 'package:sorting_visualization/setup_bottom_sheet.dart';
import 'package:sorting_visualization/setup_dialogs.dart';
import 'package:sorting_visualization/ui/ui_theme.dart';
import 'package:sorting_visualization/ui/views/home_view.dart';
import 'package:sorting_visualization/app/router.gr.dart' as auto_router;
import 'package:stacked_services/stacked_services.dart';

import 'app/locator.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  setupDialogUi();
  setupBottomSheetUI();

  final SharedPreferenceService _sharedPrefService = locator<SharedPreferenceService>();
  await _sharedPrefService.initialise();

  runApp(MyApp());
  var style = SystemUiOverlayStyle(systemNavigationBarColor: darkBackgroundFinish);
  SystemChrome.setSystemUIOverlayStyle(style);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sorting Visualizer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Color(0xffB3B3B3),
        primaryColor: orangeThemeColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Montserrat',
        canvasColor: darkBackgroundFinish
      ),
      onGenerateRoute: auto_router.Router().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      home: HomeView(),
      debugShowCheckedModeBanner: false,
    );
  }
}