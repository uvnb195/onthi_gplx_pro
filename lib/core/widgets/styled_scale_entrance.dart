import 'package:flutter/material.dart';

class StyledScaleEntrance extends StatefulWidget {
  final Duration duration, delayed;
  final bool disableAnimation;
  final double from;
  final Widget child;
  final Curve curve;
  final VoidCallback? onEnd;

  const StyledScaleEntrance({
    super.key,
    this.duration = const Duration(milliseconds: 300),
    this.delayed = const Duration(seconds: 0),
    this.disableAnimation = false,
    this.curve = Curves.easeOutBack,
    this.from = 0,
    required this.child,
    this.onEnd,
  });

  @override
  State<StyledScaleEntrance> createState() => _StyledScaleEntranceState();
}

class _StyledScaleEntranceState extends State<StyledScaleEntrance>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<double> scale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: widget.duration);
    _opacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    scale = Tween<double>(
      begin: widget.from,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    Future.delayed(widget.delayed, () {
      if (mounted) _controller.forward();
    });

    _controller.addStatusListener((event) {
      if (event == .completed) {
        widget.onEnd?.call();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.disableAnimation) return widget.child;
    return AnimatedBuilder(
      builder: (context, child) {
        return Opacity(
          opacity: _opacity.value,
          child: Transform.scale(scale: scale.value, child: widget.child),
        );
      },
      animation: _controller,
    );
  }
}
