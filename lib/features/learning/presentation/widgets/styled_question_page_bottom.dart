import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:onthi_gplx_pro/core/theme/app_colors.dart';
import 'package:onthi_gplx_pro/core/widgets/styled_animated_sized.dart';
import 'package:onthi_gplx_pro/core/widgets/styled_button.dart';

class StyledQuestionPageBottom extends StatelessWidget {
  final bool showPrev;
  const StyledQuestionPageBottom({super.key, this.showPrev = false});

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

                onPressed: () {},
              ),
            ),
          ),
          Expanded(
            child: AnimatedOpacity(
              opacity: 1,
              duration: Duration(milliseconds: 500),
              curve: Curves.easeOut,
              child: StyledButton(
                title: "Câu tiếp theo",
                suffixIcon: Icon(BootstrapIcons.chevron_right),
                backgroundColor: AppColors.primaryColor,
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
