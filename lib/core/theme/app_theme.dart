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
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light, // Android
      statusBarBrightness: Brightness.dark, // iOS
    ),
  ),
);
