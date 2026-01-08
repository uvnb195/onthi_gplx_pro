import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onthi_gplx_pro/core/router/app_router.dart';
import 'package:onthi_gplx_pro/core/router/route_names.dart';
import 'package:onthi_gplx_pro/core/theme/app_theme.dart';
import 'package:onthi_gplx_pro/dependencies_container.dart';
import 'package:onthi_gplx_pro/features/splash/presentation/bloc/splash_bloc.dart';

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
        onGenerateRoute: AppRouter.generate,
        initialRoute: RouteNames.splash,
        theme: themeData,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
