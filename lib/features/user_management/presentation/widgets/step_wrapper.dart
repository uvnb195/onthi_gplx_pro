import 'package:flutter/material.dart';
import 'package:onthi_gplx_pro/core/theme/app_colors.dart';
import 'package:onthi_gplx_pro/core/widgets/styled_button.dart';
import 'package:onthi_gplx_pro/features/user_management/presentation/widgets/indicator.dart';

class StepWrapper extends StatefulWidget {
  const StepWrapper({super.key});

  @override
  State<StepWrapper> createState() => _StepWrapperState();
}

class _StepWrapperState extends State<StepWrapper> {
  final stepCount = 3;
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
              Expanded(child: Center(child: Text("Content"))),

              // B U T T O N - S E C T I O N
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Row(
                  children: [
                    if (currentIndex > 0) ...[
                      StyledButton(
                        backgroundColor: AppColors.neutralColor,
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
                      SizedBox(width: 16),
                    ],
                    Expanded(
                      child: StyledButton(
                        title: "Tiếp tục",
                        suffixIcon: Icon(Icons.arrow_forward_ios_rounded),
                        onPressed: () {
                          setState(() {
                            currentIndex++;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
