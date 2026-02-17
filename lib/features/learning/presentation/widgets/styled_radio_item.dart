import 'package:flutter/material.dart';
import 'package:onthi_gplx_pro/core/theme/app_colors.dart';

class StyledRadioItem extends StatelessWidget {
  final bool selected;
  final int index;
  final String content;
  final VoidCallback? onTap;
  final Color? themeColor;
  const StyledRadioItem({
    super.key,
    this.selected = true,
    required this.index,
    required this.content,
    required this.onTap,
    this.themeColor,
  });

  @override
  Widget build(BuildContext context) {
    final bool isActive = themeColor != null;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: .circular(isActive ? 24 : 12),
        splashColor: AppColors.infoColor.withAlpha(30),
        child: AnimatedScale(
          scale: (isActive) ? 1.02 : 1,
          curve: Curves.easeOutBack,
          duration: const Duration(milliseconds: 300),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutBack,
            width: double.maxFinite,
            padding: .all(16),
            decoration: BoxDecoration(
              color: themeColor?.withAlpha(30),
              border: .all(
                width: themeColor != null ? 2 : 1,
                color: themeColor != null
                    ? themeColor!
                    : AppColors.textSecondaryColor.withAlpha(100),
              ),
              borderRadius: .circular(isActive ? 24 : 12),
            ),
            child: Align(
              alignment: .centerLeft,
              child: RichText(
                text: TextSpan(
                  text: '${String.fromCharCode(index + 65)}.  ',
                  style: TextStyle(fontSize: 18, fontWeight: .w500),
                  children: [
                    TextSpan(
                      text: content,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: .w400,
                        letterSpacing: 0.8,
                        wordSpacing: 2,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
