import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const primaryColor = Color(0xffFF6B35);
  static const backgroundColor = Color(0xff1A1F2E);
  static const textColor = Colors.white;
  static const textSecondaryColor = Color(0xff9CA3AF);
  static const textDisableColor = Color(0xff6B7280);
  static const neutralColor = Color(0xff252B3B);
  static const infoColor = Color(0xff3B82F6);

  static const MaterialColor primarySwatch = MaterialColor(
    0xffFF6B35,
    <int, Color>{
      50: Color(0xffFFB499),
      100: Color(0xffFFA585),
      200: Color(0xffFF9670),
      300: Color(0xffFF875C),
      400: Color(0xffE16A19),
      500: Color(0xffFF6B35),
      600: Color(0xffF54100),
      700: Color(0xffB83100), //error color
      800: Color(0xff7A2100),
      900: Color(0xff3D1000),
    },
  );
}
