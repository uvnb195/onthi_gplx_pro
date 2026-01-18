import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onthi_gplx_pro/core/theme/app_colors.dart';

ThemeData themeData = ThemeData(
  fontFamily: 'Roboto',
  scaffoldBackgroundColor: AppColors.backgroundColor,
  primaryColor: AppColors.primaryColor,
  primarySwatch: AppColors.primarySwatch,
  brightness: Brightness.dark,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.backgroundColor,
    surfaceTintColor: AppColors.backgroundColor,
    scrolledUnderElevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: AppColors.backgroundColor,
      statusBarIconBrightness: Brightness.light, // Android
      statusBarBrightness: Brightness.dark, // iOS
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: AppColors.backgroundColor,
    type: BottomNavigationBarType.fixed,
    showUnselectedLabels: false,
    selectedItemColor: AppColors.primaryColor,
    elevation: 0,
  ),
);
