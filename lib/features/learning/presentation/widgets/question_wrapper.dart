import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:onthi_gplx_pro/core/theme/app_colors.dart';
import 'package:onthi_gplx_pro/core/widgets/styled_animated_sized.dart';
import 'package:onthi_gplx_pro/features/learning/presentation/widgets/question_category.dart';
import 'package:onthi_gplx_pro/features/learning/presentation/widgets/styled_question_page_bottom.dart';
import 'package:onthi_gplx_pro/features/learning/presentation/widgets/styled_question_page_header.dart';

class QuestionWrapper extends StatefulWidget {
  final bool showCategoryButton;
  final double countdownSeconds;
  final String title;
  final int totalQuestion, currentIndex;
  final int? categoryId;
  final Widget child;
  final ValueChanged<int>? onQuestionChanged;

  const QuestionWrapper({
    super.key,
    this.countdownSeconds = 0,
    this.showCategoryButton = false,
    required this.title,
    this.categoryId,
    required this.child,
    required this.totalQuestion,
    required this.currentIndex,
    this.onQuestionChanged,
  });

  @override
  State<QuestionWrapper> createState() => _QuestionWrapperState();
}

class _QuestionWrapperState extends State<QuestionWrapper> {
  Size questionCategorySize = .zero;
  bool questionsExpanded = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    double centeredTop = (screenSize.height - questionCategorySize.height) / 2;
    double finalTop = questionsExpanded ? centeredTop : -screenSize.height;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: AppColors.neutralColor,

            title: Row(
              children: [
                Icon(BootstrapIcons.exclamation_circle_fill),
                SizedBox(width: 8),
                Text('Trốn học ???'),
              ],
            ),
            content: const Text(
              "Hãy là người có trách nhiệm. Bắt đầu việc gì thì nên kết thúc việc đó. Bạn chắc chắn muốn thoát?",
            ),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.primaryColor,
                ),
                onPressed: () => Navigator.pop(context, true),
                child: const Text('OK'),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.accentColor,
                ),
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Huỷ bỏ'),
              ),
            ],
          ),
        );
        if (shouldPop == true && context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              shape: Border(
                bottom: BorderSide(
                  color: AppColors.textSecondaryColor.withAlpha(50),
                  width: 1,
                ),
              ),
              titleSpacing: 0,
              centerTitle: true,
              title: StyledQuestionPageHeader(
                title: widget.title,
                showDoneButton: widget.currentIndex != widget.totalQuestion - 1,
                onListButtonClicked: () {
                  setState(() {
                    questionsExpanded = !questionsExpanded;
                  });
                },
              ),
            ),
            body: SafeArea(child: widget.child),
            bottomNavigationBar: SafeArea(
              child: Container(
                padding: .symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  border: .fromLTRB(
                    top: BorderSide(
                      color: AppColors.textSecondaryColor.withAlpha(50),
                    ),
                  ),
                ),
                height: kBottomNavigationBarHeight + 20,
                child: StyledQuestionPageBottom(
                  showPrev: widget.currentIndex > 0,
                  totalQuestion: widget.totalQuestion,
                  currentIndex: widget.currentIndex,
                  onNext: () {
                    if (widget.currentIndex < widget.totalQuestion - 1) {
                      widget.onQuestionChanged?.call(widget.currentIndex + 1);
                    }
                  },
                  onPrev: () {
                    if (widget.currentIndex > 0) {
                      widget.onQuestionChanged?.call(widget.currentIndex - 1);
                    }
                  },
                ),
              ),
            ),
          ),

          // Q U E S T I O N - C A T E G O R Y
          if (questionsExpanded)
            GestureDetector(
              onTap: () => setState(() => questionsExpanded = false),
              child: Container(color: Colors.black87),
            ),
          Positioned(
            top: finalTop,
            left: 24,
            right: 24,
            child: StyledAnimatedSized(
              isVisible: questionsExpanded,
              child: QuestionCategory(
                total: widget.totalQuestion,
                current: widget.currentIndex,
                onSelectedItem: (index) {
                  setState(() {
                    questionsExpanded = false;
                  });
                  widget.onQuestionChanged?.call(index);
                },
                onReady: (size) {
                  if (size != questionCategorySize) {
                    setState(() {
                      questionCategorySize = size;
                    });
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
