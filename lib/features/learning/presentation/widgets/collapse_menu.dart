import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:onthi_gplx_pro/core/router/route_names.dart';
import 'package:onthi_gplx_pro/core/theme/app_colors.dart';
import 'package:onthi_gplx_pro/core/widgets/menu_item.dart';
import 'package:onthi_gplx_pro/core/widgets/styled_scale_entrance.dart';
import 'package:onthi_gplx_pro/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:onthi_gplx_pro/features/learning/domain/entities/index.dart';
import 'package:onthi_gplx_pro/features/learning/presentation/bloc/learning_bloc.dart';

class CollapseMenuItem {
  final String title;
  final String? subTitle;
  final IconData iconData;
  final Color themeColor;
  const CollapseMenuItem({
    required this.title,
    this.subTitle,
    required this.iconData,
    required this.themeColor,
  });
}

class CollapseMenu extends StatefulWidget {
  final IconData iconData;
  final String title;
  final String? subTitle;
  final double? percentage;
  final Color themeColor;
  final List<CollapseMenuItem> items;
  final VoidCallback? onTap;
  const CollapseMenu({
    super.key,
    required this.iconData,
    required this.title,
    this.subTitle,
    this.percentage,
    this.themeColor = AppColors.primaryColor,
    required this.items,
    this.onTap,
  });

  @override
  State<CollapseMenu> createState() => _CollapseMenuState();
}

class _CollapseMenuState extends State<CollapseMenu> {
  bool collapsed = true;

  void _navigateToLearningInfoPage(
    int index,
    QuestionCategoryEntity selectedCategory,
  ) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Center(
        child: CircularProgressIndicator(color: AppColors.primaryColor),
      ),
    );

    final licenseId = switch (context.read<AuthBloc>().state) {
      Authenticated(user: var u) => u.license.value.id,
      _ => null,
    };

    final learningBloc = context.read<LearningBloc>();

    if (licenseId != null) {
      context.read<LearningBloc>().add(
        LoadLearningQuestions(category: selectedCategory, licenseId: licenseId),
      );
    }

    // Đợi cả 2 việc: Data về và ít nhất 500ms để Dialog kịp hiện ra ổn định
    await Future.wait([
      learningBloc.stream.firstWhere((state) => !state.loading),
      // Future.delayed(const Duration(milliseconds: 300)),
    ]);

    // Close Loading Dialog
    if (context.mounted) {
      Navigator.of(context, rootNavigator: true).pop();
    }

    final totalQuestions = learningBloc.state.questions.length;

    if (context.mounted) {
      Navigator.pushNamed(
        context,
        RouteNames.learningInfo,
        arguments: {
          'title': widget.items[index].title,
          'iconData': widget.items[index].iconData,
          'themeColor': widget.items[index].themeColor,
          'stats': [
            {
              'iconData': BootstrapIcons.file_earmark_text,
              'title': '$totalQuestions',
              'description': 'Câu hỏi',
            },
            {
              'iconData': BootstrapIcons.ui_checks,
              'title': '19',
              'description': 'Đã học',
            },
            {
              'iconData': BootstrapIcons.percent,
              'title': '85',
              'description': 'Tỉ lệ đúng',
            },
          ],
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return StyledScaleEntrance(
      delayed: const Duration(milliseconds: 100),
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(12),
        clipBehavior: .antiAlias,
        child: Ink(
          decoration: BoxDecoration(
            border: .all(color: widget.themeColor.withAlpha(30)),
            borderRadius: .circular(12),
            gradient: LinearGradient(
              colors: [
                Color.lerp(widget.themeColor, Colors.black, 0.9)!,
                AppColors.neutralColor,
              ],
              begin: .bottomLeft,
              end: .centerRight,
            ),
          ),
          child: InkWell(
            splashColor: widget.themeColor.withAlpha(30),
            borderRadius: .circular(12),
            onTap: () {
              setState(() {
                collapsed = !collapsed;
              });
            },
            child: Padding(
              padding: const .all(16),
              child: Column(
                children: [
                  // H E A D E R
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        // I C O N
                        Container(
                          decoration: BoxDecoration(
                            color: widget.themeColor.withAlpha(50),
                            borderRadius: .circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Icon(
                              widget.iconData,
                              color: widget.themeColor,
                              size: 24,
                            ),
                          ),
                        ),
                        SizedBox(width: 16),

                        // T E X T
                        Expanded(
                          child: Column(
                            crossAxisAlignment: .start,
                            children: [
                              Text(
                                widget.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              if (widget.subTitle != null)
                                Text(
                                  widget.subTitle!,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: AppColors.textSecondaryColor,
                                  ),
                                ),
                            ],
                          ),
                        ),

                        // C O L L A P S E - I C O N
                        SizedBox(width: 8),
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: Center(
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              transitionBuilder:
                                  (Widget child, Animation<double> animation) {
                                    return ScaleTransition(
                                      scale: animation,
                                      child: child,
                                    );
                                  },
                              child: collapsed
                                  ? Icon(
                                      BootstrapIcons.chevron_down,
                                      size: 18,
                                      key: ValueKey('icon1'),
                                    )
                                  : Icon(
                                      BootstrapIcons.x_lg,
                                      size: 18,
                                      key: ValueKey('icon2'),
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // L I S T - I T E M
                  if (!collapsed) SizedBox(height: 16),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                    child: collapsed
                        ? SizedBox.shrink()
                        : BlocBuilder<LearningBloc, LearningState>(
                            builder: (context, state) {
                              if (state.categories.isEmpty) {
                                return SizedBox.shrink();
                              }
                              return Column(
                                children: List.generate(widget.items.length, (
                                  index,
                                ) {
                                  return AnimationConfiguration.staggeredList(
                                    position: index,
                                    child: SlideAnimation(
                                      duration: const Duration(
                                        milliseconds: 500,
                                      ),
                                      horizontalOffset: -100,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          bottom:
                                              (index == widget.items.length - 1)
                                              ? 0
                                              : 12.0,
                                        ),
                                        child: MenuItem(
                                          themeColor:
                                              widget.items[index].themeColor,
                                          onTap: () {
                                            _navigateToLearningInfoPage(
                                              index,
                                              state.categories[index],
                                            );
                                          },
                                          title: widget.items[index].title,
                                          subTitle:
                                              widget.items[index].subTitle,
                                          iconData:
                                              widget.items[index].iconData,
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
