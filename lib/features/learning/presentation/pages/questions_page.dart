import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onthi_gplx_pro/features/learning/domain/entities/index.dart';
import 'package:onthi_gplx_pro/features/learning/presentation/bloc/learning_bloc.dart';
import 'package:onthi_gplx_pro/features/learning/presentation/widgets/question_content.dart';
import 'package:onthi_gplx_pro/features/learning/presentation/widgets/question_wrapper.dart';

class QuestionsPage extends StatefulWidget {
  final bool isStudy; // study or do practice test
  final String title;
  final int? categoryId;

  const QuestionsPage({
    super.key,
    this.isStudy = true,
    required this.title,
    this.categoryId,
  });

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  final ValueNotifier<int> _currentIndexNotifier = ValueNotifier(0);
  late final PageController _pageController;

  void _onPageChanged(int index) {
    _currentIndexNotifier.value = index;
    _pageController.animateToPage(
      _currentIndexNotifier.value,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  void initState() {
    _pageController = PageController();

    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _currentIndexNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final learningBloc = context.watch<LearningBloc>();
    final questions = learningBloc.state.questions;
    return ValueListenableBuilder(
      valueListenable: _currentIndexNotifier,
      builder: (context, value, child) {
        return QuestionWrapper(
          title: widget.title,
          categoryId: widget.categoryId,
          currentIndex: _currentIndexNotifier.value,
          onQuestionChanged: _onPageChanged,
          totalQuestion: questions.length,
          child: PageView.builder(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            itemCount: questions.length,
            itemBuilder: (context, index) => _buildQuestion(questions[index]),
          ),
        );
      },
    );
  }

  Widget _buildQuestion(QuestionEntity question) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: QuestionContent(
        total: 32,
        content: QuestionArgs(
          isSaved: question.status?.isSaved ?? false,
          id: question.id,
          imagePath: question.imageId,
          description: question.content,
          explanation: question.explanation,
          options: question.options
              .map(
                (opt) => OptionObject(
                  id: opt.id,
                  content: opt.content,
                  isCorrect: opt.isCorrect,
                ),
              )
              .toList(),
          isCritical: question.isCritical,
        ),
      ),
    );
  }
}
