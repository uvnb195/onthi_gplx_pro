import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onthi_gplx_pro/core/router/app_router.dart';
import 'package:onthi_gplx_pro/core/router/route_names.dart';
import 'package:onthi_gplx_pro/core/theme/app_theme.dart';
import 'package:onthi_gplx_pro/dependencies_container.dart';
import 'package:onthi_gplx_pro/features/global_blocs/auth_bloc/auth_bloc.dart';

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
      create: (context) => sl<AuthBloc>()..add(AuthStarted()),
      child: MaterialApp(
        navigatorKey: AppRouter.navigatorKey,
        onGenerateRoute: AppRouter.generate,
        initialRoute: RouteNames.splash,
        theme: themeData,
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          AuthState? prevState;

          return BlocListener<AuthBloc, AuthState>(
            listenWhen: (previous, current) {
              prevState = previous;
              return previous is AuthInitial && current is! AuthInitial ||
                  previous is Authenticated && current is Unauthenticated ||
                  previous is Unauthenticated && current is Authenticated;
            },

            listener: (context, state) {
              if (state is Authenticated) {
                AppRouter.navigatorKey.currentState?.pushReplacementNamed(
                  RouteNames.home,
                );
              } else if (state is Unauthenticated) {
                if (prevState is AuthInitial) {
                  Future.delayed(
                    const Duration(milliseconds: 3000),
                    () => AppRouter.navigatorKey.currentState
                        ?.pushReplacementNamed(RouteNames.onboarding),
                  );
                } else {
                  AppRouter.navigatorKey.currentState?.pushReplacementNamed(
                    RouteNames.onboarding,
                  );
                }
              } else if (state is AuthenticateFail) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            child: child,
          );
        },
      ),
    );
  }
}
