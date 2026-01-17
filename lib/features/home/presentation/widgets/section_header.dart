import 'package:flutter/material.dart';
import 'package:onthi_gplx_pro/core/theme/app_colors.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? subTitle;
  final VoidCallback? onSubtitlePress;
  final EdgeInsets padding;
  const SectionHeader({
    super.key,
    required this.title,
    this.subTitle,
    this.onSubtitlePress,
    this.padding = const .symmetric(horizontal: 16),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: .w700,
              letterSpacing: 1.2,
            ),
          ),
          if (subTitle != null)
            InkWell(
              onTap: onSubtitlePress,
              borderRadius: .circular(12),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Text(
                  subTitle!,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: .w500,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
