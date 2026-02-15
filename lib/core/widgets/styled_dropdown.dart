import 'package:flutter/material.dart';
import 'package:onthi_gplx_pro/core/theme/app_colors.dart';

class StyledDropdown extends StatefulWidget {
  final String? customLabel, hintText, internalLabel, errorText;
  final Widget? prefix, suffix;
  final List<Map<String, dynamic>> options;
  final ValueChanged<int?>? onChanged;
  const StyledDropdown({
    super.key,
    this.customLabel,
    this.hintText,
    this.internalLabel,
    required this.options,
    this.suffix,
    this.prefix,
    this.errorText,
    this.onChanged,
  });

  @override
  State<StyledDropdown> createState() => _StyledDropdownState();
}

class _StyledDropdownState extends State<StyledDropdown> {
  late int selected;

  @override
  void initState() {
    super.initState();
    selected = widget.options.first['id'];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            if (widget.customLabel != null) ...[
              SizedBox(
                width: double.maxFinite,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    widget.customLabel!,
                    maxLines: 1,
                    overflow: .ellipsis,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              SizedBox(height: 8),
            ],
            DropdownMenu(
              onSelected: widget.onChanged,
              enableFilter: false,
              leadingIcon: widget.prefix,
              trailingIcon: widget.suffix,
              errorText: widget.errorText,
              inputDecorationTheme: InputDecorationTheme(
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
                  borderSide: BorderSide(
                    color: AppColors.primarySwatch.shade700,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.primarySwatch.shade700,
                    width: 2,
                  ),
                ),
                errorStyle: TextStyle(color: AppColors.primarySwatch.shade700),
              ),

              width: constraints.maxWidth,
              menuStyle: MenuStyle(
                backgroundColor: .all(AppColors.neutralColor),
              ),
              hintText: widget.hintText,
              label: widget.internalLabel != null
                  ? Text(widget.internalLabel!)
                  : null,
              initialSelection: selected,
              dropdownMenuEntries: widget.options.map((
                Map<String, dynamic> option,
              ) {
                return DropdownMenuEntry<int>(
                  value: option['id'],
                  label: option['label'],
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}
