import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:onthi_gplx_pro/core/theme/app_colors.dart';
import 'package:onthi_gplx_pro/core/widgets/index.dart';

class StyledQuestionPageHeader extends StatelessWidget {
  final String title;
  final bool showCountdown;
  final bool showDoneButton;
  final bool showListButton;
  final VoidCallback? onListButtonClicked, onDoneButtonClicked;

  const StyledQuestionPageHeader({
    super.key,
    required this.title,
    this.showCountdown = true,
    this.showDoneButton = true,
    this.showListButton = true,
    this.onListButtonClicked,
    this.onDoneButtonClicked,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kToolbarHeight,
      child: Row(
        mainAxisSize: .max,
        children: [
          Text(title, style: TextStyle(fontSize: 18)),
          SizedBox(width: 8),
          Expanded(child: _buildActions()),
        ],
      ),
    );
  }

  Widget _buildActions() {
    return Container(
      padding: .only(right: 8),
      child: Row(
        mainAxisSize: .max,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withAlpha(30),
              borderRadius: .circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Row(
                children: [
                  Icon(
                    BootstrapIcons.clock,
                    size: 16,
                    color: AppColors.primaryColor,
                  ),
                  SizedBox(width: 6),
                  Text(
                    '12:34',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: .w500,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
          IconButton(
            onPressed: onListButtonClicked,
            icon: Icon(BootstrapIcons.grid_3x2_gap),
          ),

          SizedBox(width: 8),

          StyledAnimatedSized(
            isVisible: showDoneButton,
            child: SizedBox(
              height: 32,
              width: 90,
              child: ElevatedButton(
                onPressed: onDoneButtonClicked,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: AppColors.textColor,
                  padding: .zero,
                  shape: RoundedRectangleBorder(borderRadius: .circular(8)),
                ),

                child: Row(
                  mainAxisAlignment: .center,
                  children: [Text('Nộp bài'), Icon(BootstrapIcons.check_all)],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
