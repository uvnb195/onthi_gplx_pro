import 'dart:math' as math;

import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:onthi_gplx_pro/core/theme/app_colors.dart';

class _VibrationCurve extends Curve {
  final int repetitions;
  const _VibrationCurve({this.repetitions = 3});

  @override
  double transformInternal(double t) {
    return math.sin(t * math.pi * repetitions * 2);
  }
}

class StreakAnimation extends StatefulWidget {
  const StreakAnimation({super.key});

  @override
  State<StreakAnimation> createState() => _StreakAnimationState();
}

class _StreakAnimationState extends State<StreakAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem<double>(
        tween: Tween(
          begin: 0.9,
          end: 1.2,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 70,
      ),
      TweenSequenceItem<double>(tween: ConstantTween(1.2), weight: 30),
    ]).animate(_controller);
    _rotateAnimation = TweenSequence([
      TweenSequenceItem<double>(tween: ConstantTween(0.0), weight: 50),
      TweenSequenceItem<double>(
        tween: Tween(
          begin: 0.0,
          end: 0.1,
        ).chain(CurveTween(curve: _VibrationCurve(repetitions: 2))),
        weight: 50,
      ),
    ]).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color iconTemperature(int dayStreak) {
    if (dayStreak < 7) {
      return AppColors.primarySwatch.shade200;
    } else {
      return AppColors.primarySwatch.shade500;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.neutralColor,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: AppColors.primarySwatch.shade900, width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
          child: Row(
            mainAxisSize: .min,
            children: [
              _buildAnimatedIcon(BootstrapIcons.fire, iconTemperature(6)),
              SizedBox(width: 4),
              Text(
                '30 ngày',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedIcon(IconData iconData, Color color) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Transform.rotate(angle: _rotateAnimation.value, child: child),
        );
      },
      child: Icon(iconData, color: color, size: 16),
    );
  }
}
