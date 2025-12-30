import 'package:flutter/material.dart';
import 'package:onthi_gplx_pro/core/theme/app_colors.dart';
import 'package:onthi_gplx_pro/core/widgets/styled_button.dart';

class InformationStep extends StatefulWidget {
  const InformationStep({super.key});

  @override
  State<InformationStep> createState() => _InformationStepState();
}

class _InformationStepState extends State<InformationStep>
    with SingleTickerProviderStateMixin {
  bool isShowImageButton = false;
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: Duration(seconds: 3),
  );

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  Widget _buildAppLogo(BuildContext context) {
    late final Animation<double> imageScale = Tween<double>(begin: 0, end: 1)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.66, 1, curve: Curves.easeOut),
          ),
        );

    return ScaleTransition(
      scale: imageScale,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipOval(
            clipBehavior: Clip.hardEdge,
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.neutralColor,
                border: Border.all(width: 1, color: AppColors.textDisableColor),
              ),
              child: Image.asset(
                'assets/images/app_logo.png',
                fit: BoxFit.contain,
                width: 60,
                height: 60,
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 1000),
            child: isShowImageButton
                ? Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: StyledButton(
                      title: "Chọn Avatar",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                      height: 40,
                      backgroundColor: AppColors.infoColor,
                      onPressed: () {},
                    ),
                  )
                : SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
