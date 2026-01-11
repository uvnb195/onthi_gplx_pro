import 'package:flutter/material.dart';
import 'package:onthi_gplx_pro/core/theme/app_colors.dart';

class Indicator extends StatelessWidget {
  final int indexCount;
  final int currentIndex;
  const Indicator({
    super.key,
    required this.currentIndex,
    required this.indexCount,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(indexCount, (index) {
          final bool isActivated = index <= currentIndex;
          return AnimatedContainer(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            margin: EdgeInsets.symmetric(horizontal: 2),
            width: isActivated ? 20 : 10,
            height: isActivated ? 8 : 10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(999),
              color: isActivated
                  ? AppColors.primarySwatch.shade500
                  : AppColors.neutralColor,
            ),
          );
        }),
      ),
    );
  }
}
