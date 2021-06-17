import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';

class SortingColorScheme {
  List<Color> c1 = [
    Color(0xFFDEEDCF),
    Color(0xFFBFE1B0),
    Color(0xFF99D492),
    Color(0xFF74C67A),
    Color(0xFF56B870),
    Color(0xFF39A96B),
    Color(0xFF1D9A6C),
    Color(0xFF188977),
    Color(0xFF137177),
    Color(0xFF0E4D64)
  ];

  List<Color> c2 = [
    Color(0xFFA1A2A5),
    Color(0xFFADB0C6),
    Color(0xFF9CA2C6),
    Color(0xFF868EC4),
    Color(0xFF6B78C9),
    Color(0xFF5D6DDB),
    Color(0xFF455BD9),
    Color(0xFF354BD9),
    Color(0xFF1F35CD),
    Color(0xFF0C22BA)
  ];

  List<Color> getRandomColorScheme() {
    List<List<Color>> colorSchemes = [c1, c2];
    return colorSchemes[Random().nextInt(colorSchemes.length)];
  }
}
