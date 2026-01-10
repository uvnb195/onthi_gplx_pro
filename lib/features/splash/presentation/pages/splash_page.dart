import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:onthi_gplx_pro/features/splash/presentation/bloc/splash_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  SplashState? _pendingState;
  bool _isBlocReady = false;
  bool _isAnimationStopped = false;
  bool _isAnimationFinishedOnce = false;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SplashBloc>().add(SplashStarted());
    });
  }

  void _handleNavigation(SplashState state) {
    _animationController.stop();
    if (state is SplashLoading || state is SplashInitial) return;
    if (!mounted) return;
    if (state is SplashToHome) {
      Navigator.pushReplacementNamed(context, '/home');
    } else if (state is SplashToOnboarding) {
      Navigator.pushReplacementNamed(context, '/onboarding');
    } else if (state is SplashError) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(state.message)));
    }
  }

  Future<void> _playAnimation() async {
    await _animationController.forward();

    if (mounted) {
      setState(() {
        _isAnimationFinishedOnce = true;
        _isAnimationStopped = true;
      });
      if (_isBlocReady && _pendingState != null) {
        _handleNavigation(_pendingState!);
      } else {
        _animationController.repeat();
      }
    }
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
        child: BlocListener<SplashBloc, SplashState>(
          listener: (context, state) {
            if (state is! SplashLoading) {
              _pendingState = state;
              _isBlocReady = true;
            }

            if (_isAnimationFinishedOnce) {
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
                child: _isAnimationStopped
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
