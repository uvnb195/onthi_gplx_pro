import 'package:flutter/material.dart';
import 'package:onthi_gplx_pro/core/theme/app_colors.dart';

class AvatarWrapper extends StatelessWidget {
  final String imagePath;
  final double size;
  final VoidCallback? onTap;
  const AvatarWrapper({
    super.key,
    required this.imagePath,
    required this.size,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (size <= 0) return const SizedBox.shrink();

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          Ink(
            decoration: BoxDecoration(
              color: AppColors.neutralColor,
              shape: .circle,
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(size * 0.15),
                child: Image.asset(imagePath, fit: BoxFit.contain),
              ),
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: Ink(
                decoration: BoxDecoration(
                  shape: .circle,
                  border: Border.all(color: AppColors.textColor.withAlpha(50)),
                ),
                child: InkWell(
                  onTap: onTap,
                  customBorder: const CircleBorder(),
                  splashColor: AppColors.primaryColor.withAlpha(30),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
