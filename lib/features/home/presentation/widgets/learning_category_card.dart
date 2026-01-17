import 'package:flutter/material.dart';
import 'package:onthi_gplx_pro/core/theme/app_colors.dart';
import 'package:onthi_gplx_pro/features/home/presentation/widgets/circular_progress_with_percent.dart';

class LearningCategoryCard extends StatelessWidget {
  final IconData iconData;
  final String title;
  final String? subTitle;
  final double? percentage;
  final Color themeColor;
  final VoidCallback? onTap;
  final bool isDisabled;
  final String? disabledText;
  const LearningCategoryCard({
    super.key,
    required this.iconData,
    required this.title,
    this.subTitle,
    this.percentage,
    this.themeColor = AppColors.primaryColor,
    this.onTap,
    this.isDisabled = false,
    this.disabledText,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 6,
      borderRadius: BorderRadius.circular(12),
      clipBehavior: .antiAlias,
      color: isDisabled
          ? Color.lerp(AppColors.neutralColor, Colors.black, 0.5)
          : Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          border: .all(color: themeColor.withAlpha(30)),
          borderRadius: .circular(12),
          gradient: isDisabled
              ? null
              : LinearGradient(
                  colors: [
                    Color.lerp(themeColor, Colors.black, 0.9)!,
                    AppColors.neutralColor,
                  ],
                  begin: .bottomLeft,
                  end: .centerRight,
                ),
        ),
        child: InkWell(
          splashColor: themeColor.withAlpha(30),
          borderRadius: .circular(12),
          onTap: isDisabled ? null : onTap,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double overlayCircleSize = constraints.maxWidth * 0.3;
              return Stack(
                children: [
                  if (!isDisabled)
                    Positioned(
                      right: -overlayCircleSize * 0.25,
                      top: -overlayCircleSize * 0.25,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: themeColor.withAlpha(20),
                          shape: .circle,
                        ),
                        child: SizedBox(
                          height: overlayCircleSize,
                          width: overlayCircleSize,
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: .start,
                      mainAxisSize: .min,
                      children: [
                        // I C O N / P R O G R E S S - C I R C L E
                        Row(
                          mainAxisSize: .max,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: isDisabled
                                    ? AppColors.neutralColor.withAlpha(200)
                                    : themeColor.withAlpha(50),
                                borderRadius: .circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Icon(
                                  isDisabled
                                      ? Icons.lock_outline_rounded
                                      : iconData,
                                  color: isDisabled
                                      ? AppColors.textDisableColor
                                      : themeColor,
                                  size: 32,
                                ),
                              ),
                            ),
                            Spacer(),
                            if (!isDisabled && percentage != null)
                              CircularProgressWithPercent(
                                percentage: percentage!,
                              ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: isDisabled
                                ? AppColors.textDisableColor
                                : null,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (isDisabled)
                          Text(
                            disabledText ?? 'Chưa mở khoá',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: isDisabled
                                  ? AppColors.textDisableColor
                                  : null,
                            ),
                          )
                        else if (subTitle != null)
                          Text(
                            subTitle!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: isDisabled
                                  ? AppColors.textDisableColor
                                  : null,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
