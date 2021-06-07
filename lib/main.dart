import 'package:flutter/material.dart';
import 'package:sorting_visualization/ui/app/locator.dart';
import 'package:sorting_visualization/ui/views/home_view.dart';

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
      home: HomeView(),
      debugShowCheckedModeBanner: false,
    );
  }
}