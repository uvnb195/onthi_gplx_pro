import 'package:flutter/material.dart';
import 'package:onthi_gplx_pro/core/router/route_names.dart';
import 'package:onthi_gplx_pro/features/notfound/presentation/pages/notfound_page.dart';
import 'package:onthi_gplx_pro/features/user_management/presentation/pages/onboarding_page.dart';
import 'package:onthi_gplx_pro/features/splash/presentation/pages/splash_page.dart';

class AppRouter {
  static Route<dynamic> generate(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteNames.splash:
        return MaterialPageRoute(builder: (_) => SplashPage());
      case RouteNames.onboarding:
        return MaterialPageRoute(builder: (_) => OnboardingPage());

      default:
        return MaterialPageRoute(builder: (_) => NotfoundPage());
    }
  }
}
