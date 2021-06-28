import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        primaryColor: blueThemeColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Montserrat'
      ),
      onGenerateRoute: auto_router.Router().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      home: HomeView(),
      debugShowCheckedModeBanner: false,
    );
  }
}