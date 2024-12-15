import 'package:blott_news/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'Roboto',
  primarySwatch: AppColors.primarySwatch,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    color: AppColors.primary,
    iconTheme: IconThemeData(color: Colors.white),
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: Colors.black, fontFamily: 'Roboto'),
  ),
);
