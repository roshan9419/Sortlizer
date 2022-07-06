import 'package:flutter/material.dart';
import 'package:sorting_visualization/ui/ui_theme.dart';

List<ThemeData> getThemes() {
  return [
    ThemeData(
        primaryColor: blueThemeColor,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
        //colorScheme.secondary
        disabledColor: Color(0x4D5E5C5C),
        fontFamily: 'Montserrat',
        textTheme: TextTheme(
          overline: TextStyle(fontFamily: 'Montserrat', letterSpacing: 0),
        ),
        appBarTheme: AppBarTheme(backgroundColor: blueThemeColor),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(0.0)),
              borderSide: BorderSide(color: const Color(0xfffbb4b8))),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: blueThemeColor)),
          labelStyle: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 14,
            color: const Color(0xffdcdcdc),
          ),
        ),
        buttonTheme: ButtonThemeData(
          textTheme: ButtonTextTheme.accent,
          disabledColor: const Color(0xfffbd7da),
          buttonColor: blueThemeColor,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                backgroundColor: MaterialStateColor.resolveWith((states) {
                  if (states.contains(MaterialState.pressed)) {
                    return const Color(0xfffbd7da);
                  }
                  if (states.contains(MaterialState.disabled)) {
                    return const Color(0xfffbd7da);
                  }
                  return blueThemeColor;
                }),
                foregroundColor:
                    MaterialStateColor.resolveWith((states) => Colors.white))),
        tabBarTheme: TabBarTheme(
          indicator: UnderlineTabIndicator(
              borderSide: const BorderSide(width: 2.0, color: blueThemeColor)),
          labelColor: const Color(0xffec3a45),
          unselectedLabelColor: const Color(0x403e3e3e),
        ),
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: Colors.white,
        )),
    ThemeData(
        backgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.green))
  ];
}
