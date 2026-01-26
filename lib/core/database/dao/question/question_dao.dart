import 'package:drift/drift.dart';
import 'package:onthi_gplx_pro/core/database/app_database.dart';
import 'package:onthi_gplx_pro/core/database/models/question_with_choices.dart';
import 'package:onthi_gplx_pro/core/database/table/question_option_table.dart';
import 'package:onthi_gplx_pro/core/database/table/question_table.dart';

part 'question_dao.g.dart';

@DriftAccessor(tables: [QuestionTable, QuestionOptionTable])
class QuestionDao extends DatabaseAccessor<AppDatabase>
    with _$QuestionDaoMixin {
  QuestionDao(super.attachedDatabase);

  // create seed data
  Future<void> createQuestionsSeedData({
    required List<dynamic> questionsJson,
    required List<dynamic> optionsJson,
  }) async {
    await batch((batch) {
      batch.insertAll(
        questionOptionTable,
        optionsJson
            .map(
              (e) => QuestionOptionTableCompanion.insert(
                content: e['content'],
                questionId: e['questionId'],
                isCorrect: Value(e['isCorrect']),
              ),
            )
            .toList(),
      );
      batch.insertAll(
        questionTable,
        questionsJson
            .map(
              (e) => QuestionTableCompanion.insert(
                imageId: Value(e['imageId']),
                content: e['content'],
                explanation: Value(e['explanation']),
                isCritical: Value(e['isCritical'] as bool),
                categoryId: e['categoryId'],
              ),
            )
            .toList(),
      );
    });
  }

  // get questions by category
  Future<List<QuestionWithChoices>> getQuestionsByCategory(
    int categoryId,
  ) async {
    final query = select(questionTable).join([
      leftOuterJoin(
        questionOptionTable,
        questionOptionTable.questionId.equalsExp(questionTable.id),
      ),
    ]);
    final rows = await query.get();
    final groupedData = <int, QuestionWithChoices>{};
    for (var row in rows) {
      final question = row.readTable(questionTable);
      final option = row.readTableOrNull(questionOptionTable);

      final entry = groupedData.putIfAbsent(
        question.id,
        () => QuestionWithChoices(question: question, options: []),
      );
      if (option != null) {
        entry.options.add(option);
      }
    }

    return groupedData.values.toList();
  }

  // get questions by id list
  // get question with options
  // validate answer
}
