import 'package:flutter/material.dart';

class StyledAnimatedSized extends StatefulWidget {
  final bool isVisible;
  final Duration sizeDuration, scaleDuration;
  final Widget child;

  const StyledAnimatedSized({
    super.key,
    this.isVisible = true,
    required this.child,
    this.sizeDuration = const Duration(milliseconds: 100),
    this.scaleDuration = const Duration(milliseconds: 300),
  });

  @override
  State<StyledAnimatedSized> createState() => _StyledAnimatedSizedState();
}

class _StyledAnimatedSizedState extends State<StyledAnimatedSized> {
  double _scale = 0;

  @override
  void initState() {
    _scale = widget.isVisible ? 1 : 0;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant StyledAnimatedSized oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isVisible) {
      Future.delayed(widget.sizeDuration, () {
        if (mounted) {
          setState(() {
            _scale = 1;
          });
        }
      });
    } else {
      setState(() {
        _scale = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: widget.sizeDuration,
      curve: Curves.easeIn,
      child: widget.isVisible
          ? AnimatedScale(
              scale: _scale,
              duration: widget.scaleDuration,
              curve: Curves.easeOutBack,
              child: widget.child,
            )
          : SizedBox.shrink(),
    );
  }
}
