import 'package:flutter/material.dart';
import 'package:onthi_gplx_pro/core/theme/theme.dart';
import 'package:onthi_gplx_pro/presentation/splash/pages/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
    );
  }
}
