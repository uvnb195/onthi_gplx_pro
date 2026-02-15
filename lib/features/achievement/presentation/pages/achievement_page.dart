import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:onthi_gplx_pro/core/router/route_names.dart';
import 'package:onthi_gplx_pro/core/theme/app_colors.dart';
import 'package:onthi_gplx_pro/core/widgets/index.dart';
import 'package:onthi_gplx_pro/features/auth/presentation/bloc/auth_bloc.dart';

class AchievementPage extends StatefulWidget {
  const AchievementPage({super.key});

  @override
  State<AchievementPage> createState() => _AchievementPageState();
}

class _AchievementPageState extends State<AchievementPage>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;
  bool isShowAchievementBox = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this);
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        isShowAchievementBox = true;
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onContinuePressed() {
    Navigator.of(context).pushReplacementNamed(RouteNames.home);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is! Authenticated) {
          return ScreenWrapper(
            child: Center(child: Text('Vui lòng đăng nhập để xem thành tựu!')),
          );
        }
        return ScreenWrapper(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: .spaceEvenly,
                children: [
                  SizedBox(height: 10),
                  _buildHeader(context, name: state.user.name.value),

                  StyledSlideEntrance(
                    delayed: const Duration(milliseconds: 2000),
                    duration: const Duration(milliseconds: 1000),
                    from: .TOP,
                    child: Text(
                      '🌟 Lăn bánh khởi hành 🌟',
                      textAlign: .center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: .bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      StyledSlideEntrance(
                        delayed: const Duration(milliseconds: 2500),
                        duration: const Duration(milliseconds: 1000),
                        from: .BOTTOM,
                        child: Text.rich(
                          TextSpan(
                            text: 'Bạn đã sẵn sàng cho hành trình chinh phục',
                            children: [
                              TextSpan(
                                text:
                                    '\nGPLX ${state.user.license.value.label}',
                                style: TextStyle(
                                  fontWeight: .bold,
                                  fontSize: 18,
                                  color: AppColors.primarySwatch.shade200,
                                ),
                              ),
                            ],
                          ),
                          style: TextStyle(fontSize: 16),
                          textAlign: .center,
                        ),
                      ),
                      SizedBox(height: 40),
                      StyledSlideEntrance(
                        delayed: const Duration(milliseconds: 3000),
                        duration: const Duration(milliseconds: 1000),
                        from: .BOTTOM,
                        child: SizedBox(
                          width: .maxFinite,
                          child: StyledButton(
                            title: 'Tiếp tục',
                            suffixIcon: Icon(Icons.arrow_forward_ios_rounded),
                            onPressed: _onContinuePressed,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              IgnorePointer(
                child: SizedBox(
                  width: .maxFinite,
                  height: .maxFinite,
                  child: Center(
                    child: Lottie.asset(
                      'assets/lotties/congratulations.json',
                      fit: BoxFit.fitWidth,
                      height: .maxFinite,
                      repeat: false,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, {String? name}) {
    final width =
        MediaQuery.sizeOf(context).width > MediaQuery.sizeOf(context).height
        ? MediaQuery.sizeOf(context).height / 1.5
        : MediaQuery.sizeOf(context).width;
    return Column(
      mainAxisSize: .max,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          decoration: BoxDecoration(
            shape: .circle,
            color: isShowAchievementBox
                ? AppColors.neutralColor
                : AppColors.backgroundColor,
          ),
          child: Lottie.asset(
            controller: _animationController,
            height: width * 0.3,
            'assets/lotties/trophy.json',
            fit: BoxFit.contain,
            repeat: false,
            onLoaded: (composition) {
              Future.delayed(const Duration(milliseconds: 1000), () {
                _animationController
                  ..duration = composition.duration
                  ..forward();
              });
            },
          ),
        ),
        SizedBox(height: 20),

        SizedBox(
          child: Center(
            child: StyledScaleEntrance(
              delayed: const Duration(milliseconds: 1500),
              duration: const Duration(milliseconds: 500),
              child: Text(
                '${name != null ? 'Tuyệt vời, $name' : 'Chúc mừng '}!!! 🎉',
                style: TextStyle(fontSize: 20, fontWeight: .bold),
              ),
            ),
          ),
        ),
        SizedBox(
          child: Center(
            child: StyledScaleEntrance(
              delayed: const Duration(milliseconds: 1500),
              duration: const Duration(milliseconds: 500),
              child: Text(
                'Đạt được thành tựu mới!',
                style: TextStyle(fontSize: 16, fontWeight: .w300),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
