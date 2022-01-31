import 'package:flutter/material.dart';

//const Color bgColor = Color.fromRGBO(200, 200, 200, 0.75);

ThemeData globalTheme() => ThemeData(
  fontFamily: 'Yanone',
  primaryColor: Colors.brown,
  backgroundColor: const Color.fromRGBO(206, 188, 160, 1),
  splashColor: const Color.fromRGBO(206, 206, 206, 1),
  canvasColor: const Color.fromRGBO(200, 200, 200, 0.75),
  colorScheme: ColorScheme.fromSwatch(
    brightness: Brightness.light,
    primarySwatch: Colors.brown,
  ).copyWith(

    secondary: Colors.grey.shade600,
  ),

  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 18,
    ),
    bodyText2: TextStyle(
      fontSize: 18,
    ),
    headline3: TextStyle(
        fontSize: 48,
        fontFamily: 'Amatic',
        color: Colors.brown
    ),
    headline4: TextStyle(
        fontSize: 26,
        fontFamily: 'Yanone',
        color: Colors.brown
    ),
    headline5: TextStyle(
        fontSize: 22,
        fontFamily: 'Yanone',
        color: Colors.black
    ),
  ),
);