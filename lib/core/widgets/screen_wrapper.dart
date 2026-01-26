import 'package:flutter/material.dart';

class ScreenWrapper extends StatelessWidget {
  final Widget child;
  const ScreenWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final widgetSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // app logo background over
          Positioned(
            top: -40,
            right: widgetSize.width / -4,
            child: Transform.rotate(
              angle: 0,
              child: Opacity(
                opacity: 0.05,
                child: Image.asset(
                  'assets/images/app_logo.png',
                  width: widgetSize.width / 1.5,
                ),
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
