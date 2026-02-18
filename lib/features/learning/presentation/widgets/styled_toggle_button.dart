import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onthi_gplx_pro/core/theme/app_colors.dart';
import 'package:onthi_gplx_pro/core/widgets/index.dart';
import 'package:onthi_gplx_pro/features/learning/presentation/bloc/learning_bloc.dart';

class StyledToggleButton extends StatefulWidget {
  final Color themeColor;
  final Size size;
  final double padding;
  final ValueChanged<bool>? onToggleChanged;
  const StyledToggleButton({
    super.key,
    this.themeColor = AppColors.primaryColor,
    this.size = const Size(double.maxFinite, 50),
    this.padding = 8,
    this.onToggleChanged,
  });

  @override
  State<StyledToggleButton> createState() => _StyledToggleButtonState();
}

class _StyledToggleButtonState extends State<StyledToggleButton> {
  Color _getTextColor() {
    final Brightness brightness = ThemeData.estimateBrightnessForColor(
      widget.themeColor,
    );
    if (brightness == Brightness.light) {
      return AppColors.backgroundColor;
    }
    return AppColors.textColor;
  }

  bool checked = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LearningBloc, LearningState>(
      builder: (context, state) {
        final wrongQuestionCount = state.questions
            .where((q) => q.status != null && q.status!.isCorrect == false)
            .length;

        return GestureDetector(
          onTap: wrongQuestionCount <= 0
              ? null
              : () {
                  setState(() {
                    checked = !checked;
                  });
                  print('toggle status: $checked');
                  widget.onToggleChanged?.call(checked);
                },
          child: Container(
            decoration: BoxDecoration(
              color: Color.lerp(widget.themeColor, Colors.black, 0.6),
              borderRadius: .circular(9999),
            ),
            width: widget.size.width,
            height: widget.size.height,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final double itemWidth = constraints.maxWidth / 2;
                return Stack(
                  children: [
                    Positioned(
                      width: itemWidth,
                      height: constraints.maxHeight,
                      child: Center(
                        child: StyledAnimatedSized(
                          sizeDuration: Duration(milliseconds: 100),
                          isVisible: checked,
                          child: Text(
                            'Học tất cả',
                            style: TextStyle(
                              fontSize: 18,
                              color: AppColors.textSecondaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      width: itemWidth,
                      height: constraints.maxHeight,
                      right: widget.padding / 2,
                      child: Center(
                        child: StyledAnimatedSized(
                          sizeDuration: Duration(milliseconds: 100),
                          isVisible: !checked,
                          child: Text(
                            'Học câu sai ${wrongQuestionCount > 0 ? '($wrongQuestionCount)' : '🔒'}',
                            style: TextStyle(
                              fontSize: 18,
                              color: AppColors.textSecondaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 500),
                      top: widget.padding / 2,
                      left: checked
                          ? itemWidth - widget.padding / 2
                          : widget.padding / 2,
                      bottom: widget.padding / 2,
                      curve: Curves.easeOut,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        decoration: BoxDecoration(
                          border: .all(color: widget.themeColor.withAlpha(200)),
                          borderRadius: .circular(9999),
                          color: widget.themeColor,
                        ),
                        width: itemWidth,
                        height: widget.size.height - widget.padding,
                        child: Center(
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 500),
                            transitionBuilder: (child, animation) {
                              final isGoingToChecked =
                                  child.key == ValueKey('checked');
                              final beginOffset = isGoingToChecked
                                  ? const Offset(1.2, 0.0)
                                  : const Offset(-1.2, 0.0);
                              final offset = Tween<Offset>(
                                begin: beginOffset,
                                end: .zero,
                              ).animate(animation);
                              return SlideTransition(
                                position: offset,
                                child: FadeTransition(
                                  opacity: animation,
                                  child: child,
                                ),
                              );
                            },
                            child: checked
                                ? Text(
                                    key: ValueKey('checked'),
                                    'Học câu sai',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: .w500,
                                      color: _getTextColor(),
                                    ),
                                  )
                                : Text(
                                    key: ValueKey('unchecked'),
                                    'Học tất cả',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: .w500,

                                      color: _getTextColor(),
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
