import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:onthi_gplx_pro/core/router/route_names.dart';
import 'package:onthi_gplx_pro/features/global_blocs/auth_bloc/auth_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this);
  }

  Future<void> _handleNavigation(AuthState state) async {
    _animationController.stop();
    switch (state) {
      case AuthInitial():
      case Unauthenticated():
        await Future.delayed(const Duration(seconds: 2));
        if (mounted) {
          Navigator.pushReplacementNamed(context, RouteNames.onboarding);
        }
        return;
      case AuthenticateFail():
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(state.message)));
        return;
      case AuthChanged():
        return;
      case Authenticated():
        Navigator.pushReplacementNamed(context, RouteNames.home);
        return;
    }
  }

  Future<void> _playAnimation() async {
    await _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is! AuthInitial) {
              _handleNavigation(state);
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Lottie.asset(
                  'assets/lottie/app_logo.json',
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.width / 2,
                  fit: BoxFit.contain,
                  controller: _animationController,
                  onLoaded: (composition) {
                    _animationController.duration = composition.duration;
                    _playAnimation();
                  },
                ),
              ),
              SizedBox(height: 20),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 600),
                switchInCurve: Curves.easeOut,
                switchOutCurve: Curves.easeIn,
                transitionBuilder: (child, animation) {
                  final fade = FadeTransition(opacity: animation, child: child);
                  final slide = SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.3),
                      end: Offset.zero,
                    ).animate(animation),
                    child: fade,
                  );
                  return slide;
                },
                child: true
                    ? Text(
                        "Ôn thi GPLX Pro",
                        key: const ValueKey('ready'),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      )
                    : Text(
                        "Đang khởi tạo ...",
                        key: const ValueKey('loading'),
                        style: const TextStyle(fontSize: 20),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
