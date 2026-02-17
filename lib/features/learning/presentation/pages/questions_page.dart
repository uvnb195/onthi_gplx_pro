import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onthi_gplx_pro/features/learning/domain/entities/index.dart';
import 'package:onthi_gplx_pro/features/learning/presentation/bloc/learning_bloc.dart';
import 'package:onthi_gplx_pro/features/learning/presentation/widgets/question_content.dart';
import 'package:onthi_gplx_pro/features/learning/presentation/widgets/question_wrapper.dart';

class QuestionsPage extends StatefulWidget {
  final bool isStudy; // study or do practice test
  final String title;

  const QuestionsPage({super.key, this.isStudy = true, required this.title});

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  final ValueNotifier<int> _currentIndexNotifier = ValueNotifier(0);
  late final PageController _pageController;
  List<QuestionEntity> _cachedQuestions = [];
  List<Map<String, dynamic>> _answers = [];

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
    final currentState = context.read<LearningBloc>().state;
    if (currentState.questions.isNotEmpty) {
      _cachedQuestions = List.from(currentState.questions);
      _answers = List.generate(
        _cachedQuestions.length,
        (index) => ({'selectedOptionId': null, 'isCorrect': null}),
      );
    }
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
    return BlocBuilder<LearningBloc, LearningState>(
      buildWhen: (previous, current) => previous.loading != current.loading,
      builder: (context, state) {
        if (_cachedQuestions.isEmpty && state.questions.isNotEmpty) {
          _cachedQuestions = List.from(state.questions);
        }
        if (_cachedQuestions.isEmpty && state.loading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (_cachedQuestions.isEmpty) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(child: Text("Không có dữ liệu")),
          );
        }
        return ValueListenableBuilder(
          valueListenable: _currentIndexNotifier,
          builder: (context, value, child) {
            return QuestionWrapper(
              title: widget.title,
              currentIndex: _currentIndexNotifier.value,
              onQuestionChanged: _onPageChanged,
              totalQuestion: _cachedQuestions.length,
              child: PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                itemCount: _cachedQuestions.length,
                itemBuilder: (context, index) {
                  final question = _cachedQuestions[index];
                  return _buildQuestion(
                    question,
                    answer: _answers.length > index ? _answers[index] : null,
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildQuestion(
    QuestionEntity question, {
    Map<String, dynamic>? answer,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: QuestionContent(
        total: _cachedQuestions.length,
        index: _currentIndexNotifier.value + 1,
        onSelectedAnswer: (answer) {
          setState(() {
            _answers[_currentIndexNotifier.value] = {
              'selectedOptionId': answer['selectedOptionId'],
              'isCorrect': answer['isCorrect'],
            };
          });
        },
        question: QuestionEntity(
          id: question.id,
          imageId: question.imageId,
          content: question.content,
          explanation: question.explanation,
          options: question.options
              .map(
                (opt) => QuestionOptionEntity(
                  id: opt.id,
                  content: opt.content,
                  isCorrect: opt.isCorrect,
                ),
              )
              .toList(),
          isCritical: question.isCritical,
          categoryId: question.categoryId,
        ),
        selectedOptionId: answer != null ? answer['selectedOptionId'] : null,
      ),
    );
  }
}
