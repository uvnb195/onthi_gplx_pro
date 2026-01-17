import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:onthi_gplx_pro/core/theme/app_colors.dart';

class AchievementSmallCard extends StatelessWidget {
  final int level;
  const AchievementSmallCard({super.key, this.level = 0});

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.only(
      topRight: .circular(16),
      bottomLeft: .circular(16),
      bottomRight: .circular(16),
      topLeft: .circular(16),
    );

    return Material(
      borderRadius: borderRadius,
      elevation: 0,
      color: AppColors.backgroundColor,
      child: Column(
        children: [
          Ink(
            decoration: BoxDecoration(
              border: .all(color: AppColors.primaryColor.withAlpha(50)),
              gradient: LinearGradient(
                colors: [
                  AppColors.primarySwatch.shade300.withAlpha(200),
                  AppColors.primarySwatch.shade900,
                ],
                begin: Alignment(-1, -2),
                end: Alignment(1, 0.5),
              ),
              borderRadius: borderRadius,
            ),
            child: InkWell(
              borderRadius: borderRadius,
              child: Stack(
                children: [
                  Positioned(
                    top: 4,
                    right: 4,
                    child: Column(
                      children: [
                        if (level < 3) ...[
                          Icon(
                            BootstrapIcons.star_fill,
                            size: 8,
                            color: Color.lerp(
                              AppColors.secondaryColor,
                              AppColors.textColor,
                              0.7,
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(
                            BootstrapIcons.star_fill,
                            size: 8,

                            color: AppColors.textColor.withAlpha(100),
                          ),
                          SizedBox(width: 4),
                          Icon(
                            BootstrapIcons.star_fill,
                            size: 8,
                            color: AppColors.textColor.withAlpha(100),
                          ),
                        ] else
                          Icon(
                            BootstrapIcons.star_fill,
                            size: 12,
                            color: AppColors.primarySwatch.shade600,
                          ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 12,
                    ),
                    child: Image.asset(
                      'assets/images/achievements/trophy.png',
                      width: 52,
                      height: 52,
                      color: AppColors.textColor,
                      colorBlendMode: .srcIn,
                    ),
                  ),
                ],
              ),
              onTap: () {},
            ),
          ),
          Text('Tập sự'),
        ],
      ),
    );
  }
}
