import 'package:flutter/material.dart';
import 'package:sorting_visualization/ui/views/home_view.dart';
import 'package:sorting_visualization/app/router.gr.dart' as auto_router;
import 'package:stacked_services/stacked_services.dart';

import 'app/locator.dart';

Color blueThemeColor1 = Color(0xff2E4EEE);

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sorting Visualizer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Color(0xff525252),
        primaryColor: blueThemeColor1,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      onGenerateRoute: auto_router.Router().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      home: HomeView(),
      debugShowCheckedModeBanner: false,
    );
  }
}