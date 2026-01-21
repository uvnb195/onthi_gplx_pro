import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:onthi_gplx_pro/core/theme/app_colors.dart';
import 'package:onthi_gplx_pro/features/learning/presentation/widgets/question_category.dart';
import 'package:onthi_gplx_pro/features/learning/presentation/widgets/question_content.dart';
import 'package:onthi_gplx_pro/features/learning/presentation/widgets/styled_question_page_bottom.dart';
import 'package:onthi_gplx_pro/features/learning/presentation/widgets/styled_question_page_header.dart';

class QuestionsPage extends StatefulWidget {
  final bool isStudy; // study or do practice test
  final String title;

  const QuestionsPage({super.key, this.isStudy = true, required this.title});

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  late final ScrollController _controller;
  bool questionsExpanded = false;

  @override
  void initState() {
    _controller = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            content: const Text("Bạn chắc chắn muốn thoát ?"),
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
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            controller: _controller,
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverAppBar(
                shape: Border(
                  bottom: BorderSide(
                    color: AppColors.textSecondaryColor.withAlpha(50),
                    width: 1,
                  ),
                ),
                pinned: true,
                titleSpacing: 0,
                centerTitle: true,
                title: StyledQuestionPageHeader(
                  title: widget.title,
                  showDoneButton: false,
                  onListButtonClicked: () {
                    setState(() {
                      questionsExpanded = !questionsExpanded;
                      if (questionsExpanded == true) {
                        _controller.animateTo(
                          0,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.bounceOut,
                        );
                      }
                    });
                  },
                ),
              ),

              // Q U E S T I O N - C A T E G O R Y
              SliverPadding(
                padding: const .symmetric(horizontal: 16),
                sliver: SliverToBoxAdapter(
                  child: QuestionCategory(
                    currentIndex: 16,
                    expanded: questionsExpanded,
                  ),
                ),
              ),

              // Q U E S T I O N - C O N T E N T
              SliverPadding(
                padding: .all(16),
                sliver: SliverToBoxAdapter(child: QuestionContent()),
              ),
            ],
          ),
        ),
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
            child: StyledQuestionPageBottom(),
          ),
        ),
      ),
    );
  }
}
