import 'package:flutter/material.dart';
import 'package:onthi_gplx_pro/core/theme/app_colors.dart';

class StyledRadioItem extends StatelessWidget {
  final bool selected;
  final bool? isCorrect;
  final int index;
  final String content;
  final VoidCallback? onTap;
  const StyledRadioItem({
    super.key,
    this.selected = true,
    this.isCorrect,
    required this.index,
    required this.content,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textWrong = AppColors.primaryColor;
    final textCorrect = AppColors.accentColor;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: .circular(12),
        splashColor: AppColors.infoColor.withAlpha(30),
        child: Ink(
          padding: .all(12),
          decoration: BoxDecoration(
            border: .all(color: AppColors.textSecondaryColor.withAlpha(100)),
            borderRadius: .circular(12),
          ),
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
    );
  }
}
