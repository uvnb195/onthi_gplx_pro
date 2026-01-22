import 'package:flutter/material.dart';
import 'package:onthi_gplx_pro/features/learning/presentation/widgets/mock_questions.dart';
import 'package:onthi_gplx_pro/features/learning/presentation/widgets/question_content.dart';
import 'package:onthi_gplx_pro/features/learning/presentation/widgets/question_wrapper.dart';

class QuestionsPage extends StatelessWidget {
  final bool isStudy; // study or do practice test
  final String title;

  const QuestionsPage({super.key, this.isStudy = true, required this.title});

  @override
  Widget build(BuildContext context) {
    return QuestionWrapper(
      currentIndex: 0,
      title: 'Đề thi #1',
      totalQuestion: 32,
      child: Column(
        children: [
          QuestionContent(
            total: 32,
            content: QuestionArgs(
              id: mockQuestionsData[0]['id'],
              description: mockQuestionsData[0]['description'],
              explanation: mockQuestionsData[0]['explanation'],
              options: (mockQuestionsData[0]['options'] as List)
                  .map(
                    (e) => OptionObject(
                      id: e['id'],
                      content: e['content'],
                      isCorrect: e['isCorrect'],
                    ),
                  )
                  .toList(),
              isCritical: mockQuestionsData[0]['isCritical'],
            ),
          ),
        ],
      ),
    );
  }
}
