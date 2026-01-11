import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:onthi_gplx_pro/core/theme/app_colors.dart';

class RadioItem extends StatelessWidget {
  final String title;
  final String description;
  final int titleMaxLines, descriptionMaxLines;
  final bool selected;
  final Color themeColor;
  final VoidCallback? onTap;
  const RadioItem({
    super.key,
    required this.title,
    required this.description,
    this.titleMaxLines = 1,
    this.descriptionMaxLines = 2,
    this.selected = false,
    this.onTap,
    this.themeColor = AppColors.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? themeColor.withAlpha(20) : AppColors.neutralColor,
      borderRadius: .circular(8),
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: .circular(8),
        splashColor: themeColor.withAlpha(30),
        highlightColor: themeColor.withAlpha(100),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: 80, maxHeight: 150),
          child: AnimatedContainer(
            decoration: BoxDecoration(
              borderRadius: .circular(8),
              border: .all(
                color: selected
                    ? Color.lerp(themeColor, Colors.black, 0.3)!
                    : AppColors.textSecondaryColor,
                width: 2,
              ),
              gradient: LinearGradient(
                colors: [
                  Color.lerp(themeColor, Colors.black, 0.8)!.withAlpha(50),
                  AppColors.neutralColor,
                ],
                begin: selected ? .bottomRight : .topLeft,
                end: selected ? .topLeft : .bottomCenter,
              ),
            ),
            duration: const Duration(milliseconds: 300),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisSize: .min,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: .start,
                      mainAxisSize: .min,
                      children: [
                        Text(
                          title,
                          maxLines: titleMaxLines,
                          overflow: .ellipsis,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          description,
                          overflow: .ellipsis,
                          maxLines: descriptionMaxLines,
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8),
                  AnimatedSwitcher(
                    switchInCurve: Curves.bounceOut,
                    switchOutCurve: Curves.linear,
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) =>
                        ScaleTransition(scale: animation, child: child),
                    child: selected == true
                        ? Icon(
                            key: ValueKey('selected'),
                            BootstrapIcons.check_circle_fill,
                            color: selected ? themeColor : null,
                          )
                        : Icon(
                            key: ValueKey('unselected'),
                            BootstrapIcons.circle,
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
