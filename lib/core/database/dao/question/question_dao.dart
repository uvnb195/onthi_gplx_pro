import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:onthi_gplx_pro/core/database/app_database.dart';
import 'package:onthi_gplx_pro/core/database/models/question_with_options.dart';
import 'package:onthi_gplx_pro/core/database/table/index.dart';

part 'question_dao.g.dart';

@lazySingleton
@DriftAccessor(
  tables: [LicenseQuestionTable, QuestionTable, QuestionOptionTable],
)
class QuestionDao extends DatabaseAccessor<AppDatabase>
    with _$QuestionDaoMixin {
  QuestionDao(super.attachedDatabase);

  // S E E D - D A T A
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
        mode: .insertOrReplace,
      );
    });
  }

  Future<void> createLicenseQuestionsSeedData(
    List<dynamic> licenseQuestionsJson,
  ) async {
    await batch((batch) {
      final insertions = licenseQuestionsJson.expand((e) {
        final licenseId = e['license_id'];
        List<int> questionIds = List<int>.from(e['data']);
        if (questionIds.isEmpty) {
          questionIds = List.generate(600, (index) => index + 1);
        }

        return questionIds.map(
          (qId) => LicenseQuestionTableCompanion.insert(
            licenseId: licenseId as int,
            questionId: qId,
          ),
        );
      }).toList();

      batch.insertAll(licenseQuestionTable, insertions, mode: .insertOrReplace);
    });
  }

  // - - - - - - - - - - - - -
  Future<List<QuestionWithOptions>> getQuestionsByCategory({
    required int categoryId,
    required int licenseId,
  }) async {
    final query =
        select(questionTable).join([
          innerJoin(
            licenseQuestionTable,
            licenseQuestionTable.questionId.equalsExp(questionTable.id),
          ),
        ])..where(
          licenseQuestionTable.licenseId.equals(licenseId) &
              questionTable.categoryId.equals(categoryId),
        );
    final rows = await query.get();
    final questions = rows.map((r) => r.readTable(questionTable)).toList();
    final questionIds = questions.map((q) => q.id).toList();

    final allOptions = await (select(
      questionOptionTable,
    )..where((tbl) => tbl.questionId.isIn(questionIds))).get();

    return questions
        .map(
          (q) => QuestionWithOptions(
            question: q,
            options: allOptions.where((o) => o.questionId == q.id).toList(),
          ),
        )
        .toList();
  }

  // get questions by id list
  // get question with options
  // validate answer
}
