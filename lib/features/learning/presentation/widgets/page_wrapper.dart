import 'package:flutter/material.dart';
import 'package:onthi_gplx_pro/core/constants/app_assets.dart';
import 'package:onthi_gplx_pro/core/theme/app_colors.dart';

class PageWrapper extends StatelessWidget {
  final Widget child;
  const PageWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final widgetSize = MediaQuery.of(context).size;
    return Stack(
      children: [
        // app logo background over
        Container(
          width: widgetSize.width,
          height: widgetSize.height,
          color: AppColors.backgroundColor,
        ),
        Positioned(
          top: -40,
          right: widgetSize.width / -4,
          child: Transform.rotate(
            angle: 0,
            child: Opacity(
              opacity: 0.1,
              child: Image(
                image: AppAssets.logoApp,
                width: widgetSize.width / 1.5,
                gaplessPlayback: true,
              ),
            ),
          ),
        ),

        child,
      ],
    );
  }
}
