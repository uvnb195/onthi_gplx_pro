import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:onthi_gplx_pro/core/theme/app_colors.dart';

class MenuItem extends StatelessWidget {
  final IconData iconData;
  final String title;
  final String? subTitle;
  final String? rightText;
  final TextStyle rightTextStyle;
  final Color themeColor;
  final Color? backgroundColor;
  final BorderRadius borderRadius;
  final bool? showBottomBorder;
  final VoidCallback? onTap;
  const MenuItem({
    super.key,
    required this.title,
    this.subTitle,
    this.rightText,
    this.rightTextStyle = const TextStyle(),
    required this.iconData,
    this.themeColor = AppColors.primaryColor,
    this.backgroundColor,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.showBottomBorder = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: Color.lerp(
          backgroundColor ?? themeColor,
          Colors.black,
          0.5,
        )!.withAlpha(50),
        borderRadius: borderRadius,
        border: showBottomBorder == true
            ? .all(color: themeColor.withAlpha(30))
            : .fromLTRB(
                left: BorderSide(
                  color: AppColors.textSecondaryColor.withAlpha(30),
                ),
                right: BorderSide(
                  color: AppColors.textSecondaryColor.withAlpha(30),
                ),
                top: BorderSide(
                  color: AppColors.textSecondaryColor.withAlpha(30),
                ),
              ),
      ),
      child: InkWell(
        borderRadius: borderRadius,
        onTap: onTap,
        splashColor: themeColor.withAlpha(30),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              // I C O N
              Container(
                decoration: BoxDecoration(
                  color: themeColor.withAlpha(50),
                  borderRadius: .circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Icon(iconData, color: themeColor, size: 24),
                ),
              ),

              // M I D D L E - T E X T
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  mainAxisSize: .min,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontSize: 16, fontWeight: .w600),
                      maxLines: 1,
                      overflow: .ellipsis,
                    ),
                    if (subTitle != null) ...[
                      SizedBox(height: 2),
                      Text(
                        subTitle!,
                        maxLines: 2,
                        overflow: .ellipsis,
                        style: TextStyle(
                          color: AppColors.textSecondaryColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              // R I G H T - S I D E
              if (rightText != null) ...[
                SizedBox(width: 8),
                Text(
                  rightText!,
                  style: rightTextStyle.copyWith(color: themeColor),
                ),
              ],
              if (onTap != null)
                Icon(
                  BootstrapIcons.chevron_right,
                  size: 16,
                  color: AppColors.textSecondaryColor,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
