import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onthi_gplx_pro/core/theme/theme.dart';
import 'package:onthi_gplx_pro/dependencies_container.dart';
import 'package:onthi_gplx_pro/presentation/onboarding/pages/onboarding_page.dart';
import 'package:onthi_gplx_pro/presentation/splash/bloc/splash_bloc.dart';
import 'package:onthi_gplx_pro/presentation/splash/pages/splash_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initialDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SplashBloc>(),
      child: MaterialApp(
        routes: {'/onboarding': (context) => OnboardingPage()},
        theme: themeData,
        debugShowCheckedModeBanner: false,
        home: const SplashPage(),
      ),
    );
  }
}
