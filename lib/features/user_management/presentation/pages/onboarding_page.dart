import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onthi_gplx_pro/dependencies_container.dart';
import 'package:onthi_gplx_pro/features/user_management/presentation/bloc/bloc/license_bloc.dart';
import 'package:onthi_gplx_pro/features/user_management/presentation/bloc/user/user_bloc.dart';
import 'package:onthi_gplx_pro/features/user_management/presentation/widgets/step_wrapper.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<UserBloc>()),
        BlocProvider(create: (context) => sl<LicenseBloc>()),
      ],
      child: StepWrapper(),
    );
  }
}
