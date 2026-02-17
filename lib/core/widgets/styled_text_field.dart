import 'package:flutter/material.dart';
import 'package:onthi_gplx_pro/core/theme/app_colors.dart';

class StyledTextField extends StatefulWidget {
  final bool autoFocus;
  final Widget? prefix, suffix;
  final String? customLabel, hintText, internalLabel, errorText, initialValue;
  final int? maxLines, minLines;
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
    this.maxLines = 1,
    this.minLines,
    this.initialValue,
  });

  @override
  State<StyledTextField> createState() => _StyledTextFieldState();
}

class _StyledTextFieldState extends State<StyledTextField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.initialValue);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.customLabel != null) ...[
          SizedBox(
            width: double.maxFinite,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                widget.customLabel!,
                overflow: .ellipsis,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          SizedBox(height: 8),
        ],
        TextField(
          controller: _controller,
          autofocus: widget.autoFocus,
          key: Key('welcomeTextField'),
          keyboardType: widget.keyboardType,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          cursorColor: AppColors.primaryColor,
          decoration: InputDecoration(
            prefixIcon: widget.prefix,
            suffixIcon: widget.suffix,
            hintText: widget.hintText,
            label: widget.internalLabel != null
                ? Text(widget.internalLabel!)
                : null,
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: widget.errorText == null || widget.errorText!.isEmpty
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
            errorText: widget.errorText,
            errorStyle: TextStyle(color: AppColors.primarySwatch.shade700),
          ),
          onChanged: widget.onChanged,
        ),
      ],
    );
  }
}
