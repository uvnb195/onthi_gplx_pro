import 'package:flutter/material.dart';
import 'package:onthi_gplx_pro/core/theme/app_colors.dart';

class StyledButton extends StatelessWidget {
  final String? title;
  final Widget? prefixIcon; //left Icon
  final Widget? suffixIcon; //right icon
  final Color? backgroundColor;
  final Color? foregroundColor;
  final VoidCallback? onPressed;
  const StyledButton({
    super.key,
    this.title,
    this.onPressed,
    this.prefixIcon,
    this.suffixIcon,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final style = ElevatedButton.styleFrom(
      // C O L O R
      backgroundColor: backgroundColor ?? AppColors.primaryColor,
      foregroundColor: foregroundColor ?? AppColors.textColor,

      minimumSize: Size(80, 48),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(12),
      ),

      textStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
    );
    return ElevatedButton(
      onPressed: onPressed,
      style: style,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (prefixIcon != null) prefixIcon!,
          if (title != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(title!),
            ),
          if (suffixIcon != null) suffixIcon!,
        ],
      ),
    );
  }
}
