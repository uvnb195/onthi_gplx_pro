import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onthi_gplx_pro/core/theme/app_colors.dart';
import 'package:onthi_gplx_pro/core/widgets/index.dart';
import 'package:onthi_gplx_pro/features/user_management/presentation/bloc/bloc/index.dart';
import 'package:onthi_gplx_pro/features/user_management/presentation/bloc/user/index.dart';
import 'package:onthi_gplx_pro/features/user_management/presentation/widgets/indicator.dart';
import 'package:onthi_gplx_pro/features/user_management/presentation/widgets/onboarding_steps/index.dart';

class StepWrapper extends StatefulWidget {
  const StepWrapper({super.key});

  @override
  State<StepWrapper> createState() => _StepWrapperState();
}

class _StepWrapperState extends State<StepWrapper> {
  final stepCount = 3;
  int currentIndex = 0;
  double buttonOpacity = 0;
  List<StatefulWidget> get _stepList => [
    WelcomeStep(isVisible: currentIndex >= 0),
    InformationStep(isVisible: currentIndex >= 1),
    FinishStep(isVisible: currentIndex >= 2),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => setState(() {
        buttonOpacity = 1;
      }),
    );
  }

  void _onSubmit() {}

  @override
  Widget build(BuildContext context) {
    final widgetSize = MediaQuery.of(context).size;

    void onNext() {
      final int lastIndex = stepCount - 1;
      if (currentIndex == lastIndex) {
        _onSubmit();
      } else {
        if (currentIndex + 1 == lastIndex) {
          context.read<LicenseBloc>().add(LoadLicenses());
        }
        setState(() {
          currentIndex++;
        });
      }
    }

    return Scaffold(
      body: Stack(
        children: [
          // app logo background over
          Positioned(
            top: -40,
            right: widgetSize.width / -4,
            child: Transform.rotate(
              angle: 0,
              child: Opacity(
                opacity: 0.05,
                child: Image.asset(
                  'assets/images/app_logo.png',
                  width: widgetSize.width / 1.5,
                ),
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Indicator(
                      currentIndex: currentIndex,
                      indexCount: stepCount,
                    ),
                  ),

                  // C O N T E N T
                  Expanded(
                    child: IndexedStack(
                      index: currentIndex,
                      children: _stepList,
                    ),
                  ),

                  // B U T T O N - S E C T I O N
                  BlocBuilder<UserBloc, UserFormSubmissionState>(
                    builder: (context, state) {
                      bool canContinue() {
                        switch (currentIndex) {
                          case 0:
                            return state.isStep1Valid;
                          case 1:
                            return state.isStep2Valid;
                          case 2:
                            return state.isStep3Valid;
                          default:
                            return false;
                        }
                      }

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 24, top: 8),
                        child: Row(
                          children: [
                            StyledAnimatedSized(
                              sizeDuration: Duration(milliseconds: 300),
                              isVisible: currentIndex > 0,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: StyledButton(
                                  backgroundColor: AppColors.infoColor,
                                  suffixIcon: Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    size: 24,
                                  ),

                                  onPressed: () {
                                    setState(() {
                                      if (currentIndex > 0) currentIndex--;
                                    });
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: AnimatedOpacity(
                                opacity: buttonOpacity,
                                duration: Duration(milliseconds: 1000),
                                curve: Curves.easeOut,
                                child: StyledButton(
                                  title: currentIndex == stepCount - 1
                                      ? "Hoàn tất"
                                      : "Tiếp tục",
                                  suffixIcon: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                  ),
                                  backgroundColor: AppColors.primaryColor,
                                  onPressed: canContinue() ? onNext : null,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
