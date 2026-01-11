import 'package:flutter/material.dart';
import 'package:onthi_gplx_pro/core/theme/app_colors.dart';

class StyledTextField extends StatelessWidget {
  final bool autoFocus;
  final Widget? prefix, suffix;
  final String? customLabel, hintText, internalLabel, errorText;
  final ValueChanged<String>? onChanged;
  final TextInputType keyboardType;

  const StyledTextField({
    super.key,
    this.customLabel,
    this.internalLabel,
    this.hintText,
    this.errorText,
    this.prefix,
    this.suffix,
    this.onChanged,
    this.keyboardType = .name,
    this.autoFocus = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (customLabel != null) ...[
          SizedBox(
            width: double.maxFinite,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                customLabel!,
                maxLines: 1,
                overflow: .ellipsis,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          SizedBox(height: 8),
        ],
        TextField(
          autofocus: autoFocus,
          key: Key('welcomeTextField'),
          keyboardType: keyboardType,
          cursorColor: AppColors.primaryColor,
          decoration: InputDecoration(
            prefixIcon: prefix,
            suffixIcon: suffix,
            hintText: hintText,
            label: internalLabel != null ? Text(internalLabel!) : null,
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: errorText == null || errorText!.isEmpty
                    ? AppColors.primarySwatch.shade300
                    : Colors.transparent,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.primarySwatch.shade700),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.primarySwatch.shade700,
                width: 2,
              ),
            ),
            errorText: errorText,
            errorStyle: TextStyle(color: AppColors.primarySwatch.shade700),
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
