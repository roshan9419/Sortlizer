import 'package:flutter/material.dart';
import 'package:sorting_visualization/ui/views/home_view.dart';
import 'package:sorting_visualization/app/router.gr.dart' as auto_router;
import 'package:stacked_services/stacked_services.dart';

import 'app/locator.dart';

Color themeColor1 = Color(0xff5612b4);
Color themeColor2 = Color(0xff038e56);
Color themeColor3 = Color(0xff2E4EEE);
Color themeColor4 = Color(0xff33C4B3);

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
        primaryColor: themeColor4,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      onGenerateRoute: auto_router.Router().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      home: HomeView(),
      debugShowCheckedModeBanner: false,
    );
  }
}