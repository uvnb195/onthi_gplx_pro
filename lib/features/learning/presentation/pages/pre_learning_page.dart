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
  final List<Map<String, dynamic>> stats;
  const PreLearningPage({
    super.key,
    required this.title,
    required this.iconData,
    required this.themeColor,
    this.description,
    this.stats = const [],
    this.isLearning = true,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final learningBloc = context.watch<LearningBloc>();
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
                _buildHeader(),
                SizedBox(height: 16),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: _buildMode(screenWidth),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: _buildExplanation(
                    isLearning == false
                        ? learningBloc.state.examRules
                        : learningBloc.state.selectedCategory?.rules,
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
              onNext: () {
                Navigator.pushNamed(
                  context,
                  RouteNames.learning,
                  arguments: {
                    'title': title,
                    'isStudy': true,
                    'categoryId': learningBloc.state.selectedCategory?.id,
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
  }

  Widget _buildHeader() {
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
              children: List.generate(
                stats.length,
                (index) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 8,
                    ),
                    child: InfoCard(
                      backgroundColor: Color.lerp(
                        themeColor,
                        Colors.black,
                        0.8,
                      )!,
                      iconData: stats[index]['iconData'],
                      title: stats[index]['title'],
                      description: stats[index]['description'],
                      descriptionStyle: const TextStyle(
                        color: AppColors.textSecondaryColor,
                        fontSize: 12,
                        fontWeight: .w400,
                      ),
                      themeColor: themeColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildMode(double screenWidth) {
    return StyledToggleButton(
      themeColor: Color.lerp(themeColor, Colors.black, 0.2)!,
      size: screenWidth > 600 ? Size(400, 50) : Size(double.maxFinite, 50),
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
