import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:onthi_gplx_pro/core/theme/app_colors.dart';
import 'package:onthi_gplx_pro/core/widgets/styled_animated_sized.dart';
import 'package:onthi_gplx_pro/core/widgets/styled_button.dart';

class StyledQuestionPageBottom extends StatelessWidget {
  final bool showPrev, showNext;
  final int totalQuestion, currentIndex;
  final VoidCallback? onNext, onPrev;
  const StyledQuestionPageBottom({
    super.key,
    this.showPrev = false,
    this.showNext = false,
    required this.totalQuestion,
    required this.currentIndex,
    this.onNext,
    this.onPrev,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: Row(
        children: [
          StyledAnimatedSized(
            sizeDuration: Duration(milliseconds: 300),
            isVisible: showPrev,
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: StyledButton(
                backgroundColor: AppColors.infoColor,
                suffixIcon: Icon(Icons.arrow_back_ios_new_rounded, size: 24),

                onPressed: currentIndex == 0 ? null : onPrev,
              ),
            ),
          ),
          Expanded(
            child: AnimatedOpacity(
              opacity: 1,
              duration: Duration(milliseconds: 500),
              curve: Curves.easeOut,
              child: StyledButton(
                title: currentIndex == totalQuestion - 1
                    ? "Nộp bài"
                    : "Câu tiếp theo",
                suffixIcon: currentIndex == totalQuestion - 1
                    ? Icon(BootstrapIcons.check_circle_fill)
                    : Icon(BootstrapIcons.chevron_right),
                backgroundColor: currentIndex == totalQuestion - 1
                    ? Color.lerp(AppColors.accentColor, Colors.white10, 0.3)
                    : AppColors.primaryColor,
                onPressed: onNext,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
