import 'package:flutter/material.dart';
import 'package:onthi_gplx_pro/core/router/route_names.dart';
import 'package:onthi_gplx_pro/presentation/notfound/presentation/pages/notfound_page.dart';
import 'package:onthi_gplx_pro/presentation/onboarding/pages/onboarding_page.dart';
import 'package:onthi_gplx_pro/presentation/splash/pages/splash_page.dart';

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
