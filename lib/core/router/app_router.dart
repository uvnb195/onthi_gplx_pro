import 'package:flutter/material.dart';
import 'package:onthi_gplx_pro/core/router/route_names.dart';
import 'package:onthi_gplx_pro/features/achievement/presentation/pages/achievement_page.dart';
import 'package:onthi_gplx_pro/features/home/presentation/pages/home_router.dart';
import 'package:onthi_gplx_pro/features/learning/presentation/pages/questions_page.dart';
import 'package:onthi_gplx_pro/features/learning/presentation/pages/video_questions_page.dart';
import 'package:onthi_gplx_pro/features/notfound/presentation/pages/notfound_page.dart';
import 'package:onthi_gplx_pro/features/splash/presentation/pages/splash_page.dart';
import 'package:onthi_gplx_pro/features/user_management/presentation/pages/onboarding_page.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static Route<dynamic> generate(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteNames.splash:
        return MaterialPageRoute(builder: (_) => SplashPage());

      case RouteNames.onboarding:
        return MaterialPageRoute(builder: (_) => OnboardingPage());

      case RouteNames.home:
        return MaterialPageRoute(builder: (_) => HomeRouter());

      case RouteNames.learning:
        final args = routeSettings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => QuestionsPage(
            title: args['title'],
            isStudy: args['isStudy'],
            categoryId: args['categoryId'],
          ),
        );

      case RouteNames.videoLearning:
        final args = routeSettings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (_) => VideoQuestionsPage());

      case RouteNames.achievement:
        return MaterialPageRoute(builder: (_) => AchievementPage());

      default:
        return MaterialPageRoute(builder: (_) => NotfoundPage());
    }
  }
}
