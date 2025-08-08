import 'package:bubble_todo_list/core/themes/config/app_sizes.dart';
import 'package:flutter/material.dart';


class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: Colors.lightBlue,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: Colors.lightBlue),
    textTheme: _textTheme(Colors.black87),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      elevation: 0
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.blue
    ),
    iconTheme: _iconTheme(Colors.blue)
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: Colors.black,
    scaffoldBackgroundColor: Colors.grey[500],
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: Colors.blueAccent
    ),
    textTheme: _textTheme(Colors.white60),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      elevation: 0
    ),
  );

  static _textTheme(Color color) {
    return TextTheme(
      headlineLarge:  TextStyle(
        fontSize: AppSizes.textLarge,
        // fontWeight: FontWeight.bold,
        color: color
      ),
      bodyMedium: TextStyle(
        fontSize: AppSizes.textRegular,
        color: color
      ),
      labelLarge: TextStyle(
        fontSize: AppSizes.textSmall,
        // fontWeight: FontWeight.w600,
        color: color
      )
    );
  }

  static _iconTheme(Color color){
    return IconThemeData(
      size: AppSizes.iconRegular,
      color: color
    );
  }
}




