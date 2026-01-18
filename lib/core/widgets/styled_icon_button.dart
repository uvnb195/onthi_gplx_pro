import 'package:flutter/material.dart';
import 'package:onthi_gplx_pro/core/theme/app_colors.dart';

class StyledIconButton extends StatelessWidget {
  final IconData iconData;
  final VoidCallback? onTap;
  final bool isBadgeLabelVisible;
  final bool isCircleShape;
  final String? badgeLabelText;
  final Color backgroundColor;
  const StyledIconButton({
    super.key,
    required this.iconData,
    this.onTap,
    this.isBadgeLabelVisible = true,
    this.isCircleShape = false,
    this.badgeLabelText,
    this.backgroundColor = AppColors.neutralColor,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashColor: AppColors.primarySwatch.shade900,
      highlightColor: AppColors.primaryColor.withAlpha(20),
      style: IconButton.styleFrom(
        shape: isCircleShape
            ? CircleBorder()
            : RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        backgroundColor: backgroundColor.withAlpha(200),
      ),
      onPressed: onTap,
      icon: Badge(
        label: badgeLabelText != null
            ? Text(
                badgeLabelText!,
                style: TextStyle(color: AppColors.backgroundColor),
                maxLines: 1,
                overflow: .clip,
              )
            : null,
        isLabelVisible: isBadgeLabelVisible,
        backgroundColor: AppColors.primarySwatch.shade800,
        smallSize: 10,
        child: Icon(iconData, color: AppColors.infoColor.withAlpha(100)),
      ),
    );
  }
}
