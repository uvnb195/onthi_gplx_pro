import 'package:flutter/material.dart';
import 'package:onthi_gplx_pro/core/theme/app_colors.dart';

class InfoCard extends StatelessWidget {
  final IconData iconData;
  final Color themeColor;
  final Color backgroundColor;
  final String title;
  final TextStyle titleStyle;
  final String? description;
  final TextStyle descriptionStyle;
  const InfoCard({
    super.key,
    required this.iconData,
    required this.title,
    this.titleStyle = const TextStyle(fontSize: 24, fontWeight: .w700),
    this.themeColor = AppColors.primaryColor,
    this.backgroundColor = AppColors.neutralColor,
    this.description,
    this.descriptionStyle = const TextStyle(
      color: AppColors.textSecondaryColor,
      fontSize: 12,
      fontWeight: .w300,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: .all(color: themeColor.withAlpha(100)),
        borderRadius: .circular(12),
      ),
      padding: const .symmetric(vertical: 12),
      child: Column(
        mainAxisAlignment: .center,
        mainAxisSize: .min,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: Color.lerp(themeColor, Colors.black, 0.7),
              shape: .circle,
            ),

            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Icon(iconData, color: themeColor),
            ),
          ),
          SizedBox(height: 6),
          Text(
            title,
            style: titleStyle.copyWith(letterSpacing: -0.5),
            maxLines: 1,
            overflow: .clip,
          ),
          if (description != null)
            Text(
              description!.toUpperCase(),
              style: descriptionStyle,
              maxLines: 1,
              overflow: .clip,
            )
          else
            SizedBox(height: 16),
        ],
      ),
    );
  }
}
