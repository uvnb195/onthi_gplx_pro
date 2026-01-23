import 'package:flutter/material.dart';
import 'package:onthi_gplx_pro/features/learning/presentation/widgets/mock_questions.dart';
import 'package:onthi_gplx_pro/features/learning/presentation/widgets/question_content.dart';
import 'package:onthi_gplx_pro/features/learning/presentation/widgets/question_wrapper.dart';

class QuestionsPage extends StatefulWidget {
  final bool isStudy; // study or do practice test
  final String title;
  final int categoryId;

  const QuestionsPage({
    super.key,
    this.isStudy = true,
    required this.title,
    required this.categoryId,
  });

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  late final List<Map<String, dynamic>> questionsData;
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
    questionsData = mockQuestionsData;
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
    return ValueListenableBuilder(
      valueListenable: _currentIndexNotifier,
      builder: (context, value, child) {
        return QuestionWrapper(
          title: widget.title,
          categoryId: widget.categoryId,
          currentIndex: _currentIndexNotifier.value,
          onQuestionChanged: _onPageChanged,
          totalQuestion: questionsData.length,
          child: PageView.builder(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            itemCount: questionsData.length,
            itemBuilder: (context, index) => _buildQuestion(index),
          ),
        );
      },
    );
  }

  Widget _buildQuestion(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: QuestionContent(
        total: 32,
        content: QuestionArgs(
          id: questionsData[index]['id'],
          imagePath: index % 2 == 0 ? "" : null,
          description: questionsData[index]['description'],
          explanation: questionsData[index]['explanation'],
          options: (questionsData[index]['options'] as List)
              .map(
                (e) => OptionObject(
                  id: e['id'],
                  content: e['content'],
                  isCorrect: e['isCorrect'],
                ),
              )
              .toList(),
          isCritical: questionsData[index]['isCritical'],
        ),
      ),
    );
  }
}
