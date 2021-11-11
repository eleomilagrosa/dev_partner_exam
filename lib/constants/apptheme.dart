import 'package:dev_partner_exam2/constants/colors.dart';
import 'package:dev_partner_exam2/constants/font_style.dart';
import 'package:flutter/material.dart';

final ThemeData themeDataLight = ThemeData(
  fontFamily: AppFontStyle.poppins,
  brightness: Brightness.light,
  primaryColor: Colors.black,
  primaryColorBrightness: Brightness.dark,
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      primary: Colors.black
    )
  ),
  appBarTheme: const AppBarTheme(
    titleTextStyle: TextStyle(
      color: Colors.black
    ),
    backgroundColor: Colors.white,
  ),
  backgroundColor: AppColors.backgroundBtn,
  scaffoldBackgroundColor: AppColors.backgroundBtn,
  dialogBackgroundColor: AppColors.backgroundBtn,
);
