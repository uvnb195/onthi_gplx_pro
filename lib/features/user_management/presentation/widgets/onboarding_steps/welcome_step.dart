import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onthi_gplx_pro/core/theme/app_colors.dart';
import 'package:onthi_gplx_pro/core/widgets/styled_button.dart';
import 'package:onthi_gplx_pro/features/user_management/presentation/bloc/user_bloc.dart';
import 'package:onthi_gplx_pro/features/user_management/presentation/widgets/indicator.dart';

class WelcomeStep extends StatefulWidget {
  const WelcomeStep({super.key});

  @override
  State<WelcomeStep> createState() => _WelcomeStepState();
}

class _WelcomeStepState extends State<WelcomeStep>
    with SingleTickerProviderStateMixin {
  final int indexCount = 3;
  int currentIndex = 0;
  bool isShowNameField = false;

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: Duration(seconds: 4),
  );

  // A N I M A T I O N - V A L U E S
  late final Animation<Offset> titleOffset =
      Tween<Offset>(begin: Offset(0, 1), end: Offset.zero).animate(
        CurvedAnimation(parent: _controller, curve: const Interval(0.25, 0.5)),
      );
  late final Animation<double> titleOpacity = Tween<double>(begin: 0, end: 1)
      .animate(
        CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.25, 0.5, curve: Curves.easeOut),
        ),
      );

  late final Animation<Offset> descOffset =
      Tween<Offset>(begin: Offset(0, 1), end: Offset.zero).animate(
        CurvedAnimation(parent: _controller, curve: const Interval(0.5, 0.75)),
      );
  late final Animation<double> descOpacity = Tween<double>(begin: 0, end: 1)
      .animate(
        CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.5, 0.75, curve: Curves.easeOut),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildWelcomeText(context),
          SizeTransition(
            axisAlignment: -1,
            sizeFactor: CurvedAnimation(
              parent: _controller,
              curve: const Interval(0.75, 1, curve: Curves.easeOut),
            ),
            child: _buildNameField(context),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller.forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          isShowNameField = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildNameField(BuildContext context) {
    return BlocBuilder<UserBloc, UserFormSubmissionState>(
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(
              width: double.maxFinite,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  "Tên của bạn là gì?",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.person_outline_outlined,
                  color: AppColors.textSecondaryColor,
                ),
                hintText: "Tên của bạn",
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: state.nameError == null
                        ? AppColors.primarySwatch.shade300
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.primarySwatch.shade700,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.primarySwatch.shade700,
                    width: 2,
                  ),
                ),
                error: state.nameError == null
                    ? null
                    : Row(
                        children: [
                          Icon(
                            Icons.warning_amber_rounded,
                            size: 16,
                            color: AppColors.primarySwatch.shade700,
                          ),
                          SizedBox(width: 6),
                          Text(
                            state.nameError!,
                            style: TextStyle(
                              color: AppColors.primarySwatch.shade700,
                            ),
                          ),
                        ],
                      ),
              ),
              onChanged: (value) =>
                  context.read<UserBloc>().add(NameChanged(value)),
            ),
          ],
        );
      },
    );
  }

  Widget _buildWelcomeText(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 40),
        FadeTransition(
          opacity: titleOpacity,
          child: SlideTransition(
            position: titleOffset,
            child: Text(
              "Chào mừng bạn! 👋",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
          ),
        ),
        SizedBox(height: 8),
        FadeTransition(
          opacity: descOpacity,
          child: SlideTransition(
            position: descOffset,
            child: Text(
              "Hãy bắt đầu hành trình chinh phục bằng lái xe của bạn.",
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondaryColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
