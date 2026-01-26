import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:onthi_gplx_pro/core/theme/app_colors.dart';
import 'package:onthi_gplx_pro/core/widgets/styled_animated_sized.dart';
import 'package:onthi_gplx_pro/core/widgets/styled_button.dart';

class StyledQuestionPageBottom extends StatelessWidget {
  final bool showPrev, showNext, showDone;
  final int totalQuestion, currentIndex;
  final VoidCallback? onNext, onPrev;
  final Color prevTheme, nextTheme, doneTheme;
  final String? prevText, nextText, doneText;
  final Widget? prevSuffix,
      prevPrefix,
      nextSuffix,
      nextPrefix,
      doneSuffix,
      donePrefix;
  const StyledQuestionPageBottom({
    super.key,
    this.showPrev = false,
    this.showNext = true,
    this.showDone = false,
    this.totalQuestion = 3,
    this.currentIndex = 1,
    //add default variable for no-logic bottom bar
    this.onNext,
    this.onPrev,
    this.prevTheme = AppColors.secondaryColor,
    this.nextTheme = AppColors.primaryColor,
    this.doneTheme = AppColors.accentColor,
    this.prevText,
    this.nextText,
    this.doneText,
    this.prevSuffix,
    this.prevPrefix,
    this.nextSuffix,
    this.nextPrefix,
    this.doneSuffix,
    this.donePrefix,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: .only(top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StyledAnimatedSized(
            sizeDuration: Duration(milliseconds: 200),
            isVisible: showPrev,
            child: StyledButton(
              width: (showDone ? screenWidth / 3 - 32 : screenWidth / 2 - 24),
              backgroundColor: prevTheme,
              prefixIcon:
                  prevPrefix ??
                  Icon(Icons.arrow_back_ios_new_rounded, size: 24),
              title: prevText != null
                  ? prevText!
                  : screenWidth < 600
                  ? null
                  : 'Câu trước',
              suffixIcon: prevSuffix,
              onPressed: currentIndex == 0 ? null : onPrev,
            ),
          ),
          StyledAnimatedSized(
            sizeDuration: Duration(milliseconds: 200),
            isVisible: showDone,
            child: StyledButton(
              width: screenWidth / 3,
              backgroundColor: Color.lerp(doneTheme, Colors.black54, 0.1),
              title: doneText != null
                  ? doneText!
                  : screenWidth < 600
                  ? null
                  : 'Nộp bài',
              suffixIcon:
                  doneSuffix ??
                  Icon(BootstrapIcons.clipboard_check_fill, size: 24),
              prefixIcon: donePrefix,
              onPressed: currentIndex == 0 ? null : onPrev,
            ),
          ),
          StyledAnimatedSized(
            sizeDuration: Duration(milliseconds: 200),
            isVisible: showNext,
            child: StyledButton(
              width: !showPrev && !showDone
                  ? screenWidth - 32
                  : showPrev && !showDone || !showPrev && showDone
                  ? screenWidth / 2 - 24
                  : screenWidth / 3 - 32,
              title: nextText != null
                  ? nextText!
                  : screenWidth < 600
                  ? null
                  : "Câu sau",
              suffixIcon:
                  nextSuffix ?? Icon(Icons.arrow_forward_ios_rounded, size: 24),
              prefixIcon: nextPrefix,
              backgroundColor: nextTheme,
              onPressed: currentIndex == totalQuestion - 1 ? null : onNext,
            ),
          ),
        ],
      ),
    );
  }
}
