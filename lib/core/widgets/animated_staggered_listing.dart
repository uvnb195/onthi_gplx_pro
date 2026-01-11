import 'package:flutter/material.dart';
import 'package:onthi_gplx_pro/core/widgets/styled_slide_entrance.dart';

class AnimatedStaggeredListing extends StatelessWidget {
  final Duration interval;
  final Duration itemDuration;
  final double itemPadding;
  final Duration delayed;
  final VoidCallback? onEnd;

  final List<Widget> children;
  const AnimatedStaggeredListing({
    super.key,
    this.interval = const Duration(milliseconds: 1000),
    this.delayed = const Duration(milliseconds: 0),
    this.itemDuration = const Duration(milliseconds: 1000),
    this.itemPadding = 8,
    required this.children,
    this.onEnd,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: children.asMap().entries.map((e) {
        int index = e.key;
        return Padding(
          padding: EdgeInsets.only(
            bottom: index == children.length - 1 ? 0 : itemPadding,
          ),
          child: StyledSlideEntrance(
            delayed: Duration(
              milliseconds:
                  index * interval.inMilliseconds + delayed.inMilliseconds,
            ),
            duration: itemDuration,
            onEnd: index == children.length - 1 ? onEnd : null,
            child: e.value,
          ),
        );
      }).toList(),
    );
  }
}
