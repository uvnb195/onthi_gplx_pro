import 'package:flutter/material.dart';
import 'package:onthi_gplx_pro/core/theme/app_colors.dart';

class StyledButton extends StatelessWidget {
  final String? title;
  final TextStyle? style;
  final Widget? prefixIcon; //left Icon
  final Widget? suffixIcon; //right icon
  final Color? backgroundColor;
  final Color? foregroundColor;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  const StyledButton({
    super.key,
    this.title,
    this.style,
    this.onPressed,
    this.prefixIcon,
    this.suffixIcon,
    this.backgroundColor,
    this.foregroundColor,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final buttonStyle = ElevatedButton.styleFrom(
      // C O L O R
      backgroundColor: backgroundColor ?? AppColors.primaryColor,
      foregroundColor: foregroundColor ?? AppColors.textColor,

      minimumSize: Size(width ?? 80, height ?? 48),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(12),
      ),
      shadowColor: backgroundColor ?? AppColors.primaryColor,
      elevation: 4,

      textStyle: style ?? TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
    );
    return ElevatedButton(
      onPressed: onPressed,
      style: buttonStyle,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
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
