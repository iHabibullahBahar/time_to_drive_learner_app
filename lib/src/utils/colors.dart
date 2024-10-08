import 'package:flutter/material.dart';

///Primary Swatch
const zPrimarySwatch = MaterialColor(
  0xFF4cd8db,
  <int, Color>{
    50: Color(0xFFedfbfb),
    100: Color(0xFFc8f3f4),
    200: Color(0xFFadedee),
    300: Color(0xFF87e5e7),
    400: Color(0xFF70e0e2),
    500: Color(0xFF4cd8db),
    600: Color(0xFF45c5c7),
    700: Color(0xFF36999b),
    800: Color(0xFF2a7778),
    900: Color(0xFF205b5c),
  },
);

///Secondary Swatch
const MaterialColor zSecondarySwatch = MaterialColor(
  0xFF132128,
  <int, Color>{
    50: Color(0xFFe7e9ea),
    100: Color(0xFFb6babc),
    200: Color(0xFF92999c),
    300: Color(0xFF616a6f),
    400: Color(0xFF424d53),
    500: Color(0xFF132128),
    600: Color(0xFF111e24),
    700: Color(0xFF0d171c),
    800: Color(0xFF0a1216),
    900: Color(0xFF080e11),
  },
);

///Gray Swatch
const MaterialColor zGraySwatch = MaterialColor(
  0xFF667085,
  <int, Color>{
    50: Color(0xFFf0f1f3),
    100: Color(0xFFd0d3d9),
    200: Color(0xFFb9bdc7),
    300: Color(0xFF989fad),
    400: Color(0xFF858d9d),
    500: Color(0xFF667085),
    600: Color(0xFF5d6679),
    700: Color(0xFF48505e),
    800: Color(0xFF383e49),
    900: Color(0xFF2b2f38),
  },
);

///Success Swatch
const MaterialColor zSuccessSwatch = MaterialColor(
  0xFF3cb744,
  <int, Color>{
    50: Color(0xFFecf8ec),
    100: Color(0xFFc3e9c5),
    200: Color(0xFFa5dea9),
    300: Color(0xFF7ccf82),
    400: Color(0xFF63c569),
    500: Color(0xFF3cb744),
    600: Color(0xFF37a73e),
    700: Color(0xFF2b8230),
    800: Color(0xFF216525),
    900: Color(0xFF194d1d),
  },
);

///Info Swatch
const MaterialColor zInfoSwatch = MaterialColor(
  0xFF2b8aff,
  <int, Color>{
    50: Color(0xFFeaf3ff),
    100: Color(0xFFbddbff),
    200: Color(0xFF9dc9ff),
    300: Color(0xFF71b1ff),
    400: Color(0xFF55a1ff),
    500: Color(0xFF2b8aff),
    600: Color(0xFF277ee8),
    700: Color(0xFF1f62b5),
    800: Color(0xFF184c8c),
    900: Color(0xFF123a6b),
  },
);

///Warning Swatch
const MaterialColor zWarningSwatch = MaterialColor(
  0xFFffb311,
  <int, Color>{
    50: Color(0xFFfff7e7),
    100: Color(0xFFffe7b5),
    200: Color(0xFFffdc92),
    300: Color(0xFFffcc60),
    400: Color(0xFFffc241),
    500: Color(0xFFffb311),
    600: Color(0xFFe8a30f),
    700: Color(0xFFb57f0c),
    800: Color(0xFF8c6209),
    900: Color(0xFF6b4b07),
  },
);

///Error Swatch
const MaterialColor zErrorSwatch = MaterialColor(
  0xFFFF3B5E,
  <int, Color>{
    50: Color(0xFFffeef2),
    100: Color(0xFFffccd7),
    200: Color(0xFFffb3c3),
    300: Color(0xFFff7a97),
    400: Color(0xFFdb6f6f),
    500: Color(0xFFff597d),
    600: Color(0xFFe85172),
    700: Color(0xFFb53f59),
    800: Color(0xFF8c3145),
    900: Color(0xFF6b2535),
  },
);

const zPrimaryGradientTopToBottom = LinearGradient(
  colors: [Color(0xFFFF6654), Color(0xFFEF7922)],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);
const zPrimaryGradientLeftToRight = LinearGradient(
  colors: [Color(0xFF007BFF), Color(0xFF007BFF)],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);
//Colors
const zPrimaryColor = Color(0xFF007BFF);
const zSecondaryColor = Color(0xFF28A745);
const zWhiteColor = Color(0xFFFFFFFF);
const zBlackColor = Color(0xFF000000);

//Text Colors
const zTextColor = Color(0xFF000000);
const zTextColorLight = Color(0xFFFFFFFF);
const zTextColorPrimary = Color(0xFF007BFF);

//Background Colors
const zBackgroundColor = Color(0xFFFFFFFF);
//const zBackgroundColor = Colors.yellow;
