import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:onthi_gplx_pro/core/theme/app_colors.dart';

class StyledBottomNavbar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  const StyledBottomNavbar({
    super.key,
    this.currentIndex = 0,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> navItems = [
      {'label': 'Trang chủ', 'icon': BootstrapIcons.house},
      {'label': 'Học tập', 'icon': BootstrapIcons.book},
      {'label': 'Trang chủ', 'icon': BootstrapIcons.bar_chart_line},
      {'label': 'Hồ sơ', 'icon': BootstrapIcons.person},
    ];
    return Container(
      height: 60 + MediaQuery.of(context).padding.bottom,
      decoration: BoxDecoration(color: Colors.transparent),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final bottom = MediaQuery.of(context).padding.bottom;
          final double width = constraints.maxWidth;
          final double itemWidth = width / navItems.length;
          return Stack(
            children: [
              // I N D I C A T O R
              AnimatedPositioned(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                left: currentIndex * itemWidth,
                child: SizedBox(
                  width: itemWidth,
                  height: 4,
                  child: Center(
                    child: SizedBox(
                      height: double.maxFinite,
                      width: itemWidth / 2,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: .only(
                            bottomLeft: Radius.circular(999),
                            bottomRight: Radius.circular(999),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: .end,
                children: List.generate(navItems.length, (index) {
                  final selected = currentIndex == index;

                  return Expanded(
                    child: Material(
                      color: Colors.transparent,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: bottom),
                        child: InkWell(
                          splashColor: AppColors.primaryColor.withAlpha(30),
                          onTap: () => onTap(index),
                          child: Column(
                            mainAxisAlignment: .end,
                            children: [
                              Transform.translate(
                                offset: selected ? Offset.zero : Offset(0, 6),
                                child: AnimatedScale(
                                  scale: selected ? 1.1 : 1,
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeOutBack,
                                  child: Icon(
                                    navItems[index]['icon'],
                                    color: selected
                                        ? AppColors.primaryColor
                                        : AppColors.textDisableColor,
                                  ),
                                ),
                              ),
                              SizedBox(height: 4),
                              AnimatedScale(
                                scale: currentIndex == index ? 1 : 0,
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeOutBack,
                                child: Text(
                                  navItems[index]['label'],
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: selected
                                        ? AppColors.primaryColor
                                        : AppColors.textDisableColor,
                                  ),
                                ),
                              ),
                              SizedBox(height: 4),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          );
        },
      ),
    );
  }
}
