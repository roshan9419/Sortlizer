import 'package:flutter/material.dart';
import 'package:sorting_visualization/ui/views/home_view.dart';

Color blueThemeColor1 = Color(0xff2E4EEE);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Color(0xff525252),
        primaryColor: blueThemeColor1,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeView(), //MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}