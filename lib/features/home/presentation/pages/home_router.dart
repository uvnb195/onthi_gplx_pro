import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onthi_gplx_pro/core/di/injection.dart';
import 'package:onthi_gplx_pro/features/home/presentation/pages/home_page.dart';
import 'package:onthi_gplx_pro/features/home/presentation/widgets/styled_home_bottom_navbar.dart';
import 'package:onthi_gplx_pro/features/learning/presentation/bloc/learning_bloc.dart';
import 'package:onthi_gplx_pro/features/learning/presentation/pages/learning_dashboard_page.dart';
import 'package:onthi_gplx_pro/features/profile/presentation/pages/profile_page.dart';
import 'package:onthi_gplx_pro/features/progress/presentation/pages/progress_page.dart';

class HomeRouter extends StatefulWidget {
  const HomeRouter({super.key});

  @override
  State<HomeRouter> createState() => _HomeRouterState();
}

class _HomeRouterState extends State<HomeRouter> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    Widget buildBody() {
      switch (currentIndex) {
        case 0:
          return HomePage();
        case 1:
          return LearningDashBoardPage();
        case 2:
          return ProgressPage();
        case 3:
          return ProfilePage();
        default:
          return Placeholder();
      }
    }

    return BlocProvider(
      create: (context) =>
          sl<LearningBloc>()..add(LoadCategories(licenseId: 3)),
      child: Scaffold(
        body: buildBody(),
        bottomNavigationBar: StyledBottomNavbar(
          currentIndex: currentIndex,
          onTap: (value) => setState(() {
            currentIndex = value;
          }),
        ),
      ),
    );
  }
}
