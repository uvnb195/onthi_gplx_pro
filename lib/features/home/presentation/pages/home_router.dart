import 'package:flutter/material.dart';
import 'package:onthi_gplx_pro/features/home/presentation/pages/home_page.dart';
import 'package:onthi_gplx_pro/features/home/presentation/widgets/styled_home_bottom_navbar.dart';
import 'package:onthi_gplx_pro/features/learning/presentation/pages/learning_page.dart';

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
          return LearningPage();
        default:
          return Placeholder();
      }
    }

    return Scaffold(
      body: SafeArea(child: buildBody()),
      bottomNavigationBar: StyledBottomNavbar(
        currentIndex: currentIndex,
        onTap: (value) => setState(() {
          currentIndex = value;
        }),
      ),
    );
  }
}
