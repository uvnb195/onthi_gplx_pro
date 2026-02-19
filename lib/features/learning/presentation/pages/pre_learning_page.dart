import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onthi_gplx_pro/core/router/route_names.dart';
import 'package:onthi_gplx_pro/core/theme/app_colors.dart';
import 'package:onthi_gplx_pro/features/learning/domain/entities/category_rule.dart';
import 'package:onthi_gplx_pro/features/learning/presentation/bloc/learning_bloc.dart';
import 'package:onthi_gplx_pro/features/learning/presentation/widgets/page_wrapper.dart';
import 'package:onthi_gplx_pro/features/learning/presentation/widgets/styled_question_page_bottom.dart';
import 'package:onthi_gplx_pro/features/learning/presentation/widgets/styled_toggle_button.dart';
import 'package:onthi_gplx_pro/features/progress/presentation/widgets/info_card.dart';

class PreLearningPage extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Color themeColor;
  final String? description;
  final bool isLearning;
  const PreLearningPage({
    super.key,
    required this.title,
    required this.iconData,
    required this.themeColor,
    this.description,
    this.isLearning = true,
  });

  @override
  Widget build(BuildContext context) {
    bool isLearnWrongQuestions = true;

    final screenWidth = MediaQuery.sizeOf(context).width;
    return BlocBuilder<LearningBloc, LearningState>(
      builder: (context, state) {
        List<Map<String, dynamic>> getStats() {
          final stats = List<Map<String, dynamic>?>.generate(3, (_) => null);

          final totalQuestions = state.questions.length;

          stats[0] = ({
            'content': totalQuestions.toString(),
            'description': 'Câu hỏi',
            'iconData': BootstrapIcons.file_earmark_text,
          });
          if (isLearning) {
            final totalLearned = state.questions
                .where((q) => q.status != null && q.status!.optionId != null)
                .length;
            final incorrectCount = state.questions
                .where((q) => q.status != null && q.status!.isCorrect == true)
                .length;
            final accuracyRate = totalLearned == 0
                ? 0
                : incorrectCount / totalLearned * 100;

            stats[1] = ({
              'content': totalLearned.toString(),
              'description': 'Đã học',
              'iconData': BootstrapIcons.ui_checks,
            });
            stats[2] = ({
              'content': accuracyRate.floor().toString(),
              'description': 'Tỉ lệ đúng',
              'iconData': BootstrapIcons.percent,
            });
          } else {
            stats[1] = ({
              'content': 19.toString(),
              'description': 'Phút',
              'iconData': BootstrapIcons.alarm,
            });
            stats[2] = ({
              'content': "21/24",
              'description': 'Tối thiểu',
              'iconData': BootstrapIcons.clipboard_check,
            });
          }

          return List.from(stats);
        }

        return PageWrapper(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              automaticallyImplyActions: false,
              shape: Border(
                bottom: BorderSide(
                  color: AppColors.textSecondaryColor.withAlpha(50),
                  width: 1,
                ),
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                child: Column(
                  children: [
                    _buildHeader(stats: getStats()),
                    SizedBox(height: 16),

                    if (state.questions.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: _buildMode(
                          screenWidth,
                          onToggleChanged: (value) =>
                              isLearnWrongQuestions = value,
                        ),
                      ),
                    SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: _buildExplanation(
                        isLearning == false
                            ? state.examRules
                            : state.selectedCategory?.rules,
                      ),
                    ),

                    SizedBox(height: 40),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: StyledQuestionPageBottom(
                  nextText: 'Bắt đầu',
                  prevText: '',
                  showDone: false,
                  showPrev: false,
                  onNext: state.questions.isEmpty
                      ? null
                      : () {
                          Navigator.pushNamed(
                            context,
                            RouteNames.learning,
                            arguments: {
                              'title': title,
                              'isStudy': true,
                              'isLearnWrongQuestions': isLearnWrongQuestions,
                            },
                          );

                          // Navigator.pushNamed(
                          //   context,
                          //   RouteNames.videoLearning,
                          //   arguments: screenWidth > 600,
                          // );
                        },
                  onPrev: () {},
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader({required List<Map<String, dynamic>> stats}) {
    Color getIconColor() {
      final Brightness brightness = ThemeData.estimateBrightnessForColor(
        themeColor,
      );
      if (brightness == Brightness.light) {
        return AppColors.backgroundColor;
      }
      return AppColors.textColor;
    }

    return Column(
      mainAxisSize: .min,
      children: [
        SizedBox(height: 24),
        Container(
          decoration: BoxDecoration(
            color: themeColor,
            borderRadius: .circular(12),
          ),
          padding: .all(16),
          child: Icon(iconData, size: 40, color: getIconColor()),
        ),
        SizedBox(height: 16),
        Text(
          title,
          style: TextStyle(fontSize: 28, fontWeight: .w700, letterSpacing: 1.2),
        ),
        if (description != null)
          Text(
            description!,
            style: TextStyle(
              fontSize: 16,
              fontWeight: .w400,
              color: AppColors.textSecondaryColor,
            ),
          ),
        if (stats.isNotEmpty) ...[
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: List.generate(stats.length, (index) {
                final displayDescription = stats[index]['description'];
                final displayTitle = stats[index]['content'];

                return Expanded(
                  child: _buildHeaderItem(
                    content: displayTitle,
                    description: displayDescription,
                    iconData: stats[index]['iconData'] as IconData,
                    isLocked: int.tryParse(stats[index]['content']) == 0,
                  ),
                );
              }),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildHeaderItem({
    required String content,
    required String description,
    required IconData iconData,
    bool isLocked = false,
  }) {
    if (isLocked) {
      return Padding(
        padding: const .all(8),
        child: InfoCard(
          backgroundColor: Color.lerp(
            AppColors.textDisableColor,
            Colors.black,
            0.6,
          )!,
          iconData: iconData,
          title: content,
          titleStyle: TextStyle(
            color: AppColors.textDisableColor,
            fontSize: 24,
            fontWeight: .w700,
          ),
          description: description,
          descriptionStyle: const TextStyle(
            color: AppColors.textSecondaryColor,
            fontSize: 12,
            fontWeight: .w400,
          ),
          themeColor: AppColors.textDisableColor,
        ),
      );
    }

    return Padding(
      padding: const .all(8),
      child: InfoCard(
        backgroundColor: Color.lerp(themeColor, Colors.black, 0.8)!,
        iconData: iconData,
        title: content,
        description: description,
        descriptionStyle: const TextStyle(
          color: AppColors.textSecondaryColor,
          fontSize: 12,
          fontWeight: .w400,
        ),
        themeColor: themeColor,
      ),
    );
  }

  Widget _buildMode(double screenWidth, {Function(bool)? onToggleChanged}) {
    return StyledToggleButton(
      themeColor: Color.lerp(themeColor, Colors.black, 0.2)!,
      size: screenWidth > 600 ? Size(400, 50) : Size(double.maxFinite, 50),
      onToggleChanged: onToggleChanged,
    );
  }

  Widget _buildExplanation(List<CategoryRuleEntity>? rules) {
    if (rules == null || rules.isEmpty) {
      return SizedBox.shrink();
    }
    return Container(
      decoration: BoxDecoration(
        color: AppColors.neutralColor,
        border: .all(color: AppColors.primaryColor.withAlpha(30)),
        borderRadius: .circular(12),
      ),
      padding: .all(16),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 100),
        child: Column(
          mainAxisAlignment: .start,
          crossAxisAlignment: .start,
          mainAxisSize: .min,
          children: [
            Row(
              children: [
                Icon(BootstrapIcons.exclamation_circle_fill, size: 18),
                SizedBox(width: 8),
                Text(
                  'Thông tin :',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: .w500,
                    color: AppColors.textColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            ...rules.map((e) {
              print('rules: $e');
              return _buildExplanationItem(
                title: e.title,
                description: e.content,
                level: e.level,
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildExplanationItem({
    required String title,
    required String description,
    int level = 1,
  }) {
    String getHeaderChar() {
      return switch (level) {
        1 => '•',
        int() => '◦',
      };
    }

    return SizedBox(
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: level == 1 ? 0 : 16),
              child: RichText(
                text: TextSpan(
                  text:
                      '${getHeaderChar()} $title${title.isNotEmpty ? ':' : ""} ',

                  style: TextStyle(fontWeight: .w500, fontSize: 16),
                  children: [
                    TextSpan(
                      text: description,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: .w400,
                        wordSpacing: 1,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
