import 'package:flutter/material.dart';
import 'package:onthi_gplx_pro/features/main_layout/presentation/widgets/section_header.dart';

class SectionWrapper extends StatelessWidget {
  final String? title;
  final bool showNavigate;
  final Widget child;
  const SectionWrapper({
    super.key,
    this.title,
    this.showNavigate = false,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: .min,
      children: [
        if (title != null) ...[
          SectionHeader(
            title: title!,
            subTitle: showNavigate ? 'Xem tất cả' : null,
            onSubtitlePress: () {},
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SizedBox(child: child),
          ),
          SizedBox(height: 8),
        ],
      ],
    );
  }
}
