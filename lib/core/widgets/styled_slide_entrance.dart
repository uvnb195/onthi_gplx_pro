import 'package:flutter/material.dart';

enum AnimatedFrom { TOP, BOTTOM, LEFT, RIGHT }

class StyledSlideEntrance extends StatefulWidget {
  final Duration duration, delayed;
  final bool disableAnimation;
  final double range;
  final AnimatedFrom from;
  final Widget child;
  final VoidCallback? onEnd;

  const StyledSlideEntrance({
    super.key,
    this.duration = const Duration(milliseconds: 300),
    this.delayed = const Duration(seconds: 0),
    this.disableAnimation = false,
    this.from = AnimatedFrom.BOTTOM,
    this.range = 40,
    required this.child,
    this.onEnd,
  });

  @override
  State<StyledSlideEntrance> createState() => _StyledSlideEntranceState();
}

class _StyledSlideEntranceState extends State<StyledSlideEntrance>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<Offset> offset;

  Offset _animatedFrom() {
    switch (widget.from) {
      case AnimatedFrom.TOP:
        return Offset(0, -widget.range);
      case AnimatedFrom.BOTTOM:
        return Offset(0, widget.range);
      case AnimatedFrom.LEFT:
        return Offset(-widget.range, 0);
      case AnimatedFrom.RIGHT:
        return Offset(widget.range, 0);
    }
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: widget.duration);
    _opacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    offset = Tween<Offset>(
      begin: _animatedFrom(),
      end: .zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    Future.delayed(widget.delayed, () {
      if (mounted) _controller.forward();
    });

    _controller.addStatusListener((status) {
      widget.onEnd?.call();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.disableAnimation) return widget.child;
    return AnimatedBuilder(
      builder: (context, child) {
        return Opacity(
          opacity: _opacity.value,
          child: Transform.translate(offset: offset.value, child: widget.child),
        );
      },
      animation: _controller,
    );
  }
}
