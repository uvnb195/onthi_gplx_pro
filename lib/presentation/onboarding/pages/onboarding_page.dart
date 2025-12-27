import 'package:flutter/material.dart';
import 'package:onthi_gplx_pro/presentation/onboarding/steps/welcome_step.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: WelcomeStep()));
  }
}
