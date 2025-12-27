import 'package:flutter/material.dart';
import 'package:onthi_gplx_pro/core/widgets/styled_button.dart';
import 'package:onthi_gplx_pro/presentation/onboarding/widgets/indicator.dart';

class WelcomeStep extends StatefulWidget {
  const WelcomeStep({super.key});

  @override
  State<WelcomeStep> createState() => _WelcomeStepState();
}

class _WelcomeStepState extends State<WelcomeStep> {
  final int indexCount = 3;
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(width: 1)),
      child: Column(
        children: [
          Indicator(currentIndex: currentIndex, indexCount: indexCount),
          SizedBox(height: 40),
          Row(
            children: [
              StyledButton(
                suffixIcon: Icon(Icons.arrow_back_ios_new_rounded, size: 24),

                onPressed: () {
                  setState(() {
                    if (currentIndex >= 0) currentIndex--;
                  });
                },
              ),
              SizedBox(width: 16),
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
        ],
      ),
    );
  }
}
