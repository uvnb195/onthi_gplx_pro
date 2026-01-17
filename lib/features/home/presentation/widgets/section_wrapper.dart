import 'package:flutter/material.dart';
import 'package:onthi_gplx_pro/features/home/presentation/widgets/section_header.dart';

class SectionWrapper extends StatelessWidget {
  final String? title;
  final bool showNavigate;
  final Widget child;
  final EdgeInsets padding;
  const SectionWrapper({
    super.key,
    this.title,
    this.showNavigate = false,
    required this.child,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    if (title == null) {
      return Padding(
        padding: padding.copyWith(top: 24),
        child: SizedBox(width: double.maxFinite, child: child),
      );
    }
    return Column(
      mainAxisSize: .min,
      crossAxisAlignment: .start,
      children: [
        if (title != null) ...[
          SizedBox(height: 24),
          SectionHeader(
            title: title!,
            subTitle: showNavigate ? 'Xem tất cả' : null,
            onSubtitlePress: () {},
          ),
          SizedBox(height: 8),
          Padding(
            padding: padding,
            child: SizedBox(width: double.maxFinite, child: child),
          ),
          SizedBox(height: 8),
        ],
      ],
    );
  }
}
