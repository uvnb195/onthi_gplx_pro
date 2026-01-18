import 'package:flutter/material.dart';
import 'package:onthi_gplx_pro/core/theme/app_colors.dart';

class PageHeader extends StatelessWidget {
  final Widget content;
  final List<Widget>? actions;
  const PageHeader({super.key, required this.content, this.actions});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: .fromLTRB(
          bottom: BorderSide(
            width: 1,
            color: AppColors.textDisableColor.withAlpha(100),
          ),
        ),
      ),
      width: .maxFinite,
      height: kToolbarHeight,

      child: Stack(
        children: [
          Align(child: content),
          if (actions != null)
            Positioned(
              right: 8,
              top: 0,
              bottom: 0,
              child: Row(mainAxisSize: MainAxisSize.min, children: actions!),
            ),
        ],
      ),
    );
  }
}
