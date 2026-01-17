import 'package:flutter/material.dart';
import 'package:onthi_gplx_pro/core/theme/app_colors.dart';

class CircularProgressWithPercent extends StatelessWidget {
  final double percentage;
  const CircularProgressWithPercent({super.key, this.percentage = 1});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 48,
      child: Stack(
        fit: .expand,
        children: [
          CircularProgressIndicator(
            value: 1,
            strokeWidth: 8,
            color: AppColors.primarySwatch.shade900,
          ),

          Center(
            child: TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: percentage),
              duration: const Duration(seconds: 2),
              curve: Curves.easeOut,
              builder: (context, value, child) => Center(
                child: SizedBox(
                  height: 48,
                  width: 48,
                  child: Stack(
                    fit: .expand,
                    children: [
                      CircularProgressIndicator(
                        value: value,
                        strokeCap: .round,
                        strokeWidth: 4,
                        color: AppColors.accentColor,
                      ),
                      Center(child: Text('${(value * 100).toInt()}%')),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
