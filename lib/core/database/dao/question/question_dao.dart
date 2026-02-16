import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:onthi_gplx_pro/core/database/app_database.dart';
import 'package:onthi_gplx_pro/core/database/models/question_with_details.dart';
import 'package:onthi_gplx_pro/core/database/table/index.dart';

part 'question_dao.g.dart';

@lazySingleton
@DriftAccessor(
  tables: [
    LicenseQuestionTable,
    QuestionTable,
    QuestionOptionTable,
    QuestionStatusTable,
  ],
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
  Stream<List<QuestionWithDetails>> watchQuestionsByCategory({
    required int categoryId,
    required int licenseId,
    required int userId,
  }) {
    final query =
        select(questionTable).join([
          innerJoin(
            licenseQuestionTable,
            licenseQuestionTable.questionId.equalsExp(questionTable.id),
          ),
          innerJoin(
            questionOptionTable,
            questionOptionTable.questionId.equalsExp(questionTable.id),
          ),
          leftOuterJoin(
            questionStatusTable,
            questionStatusTable.questionId.equalsExp(questionTable.id) &
                questionStatusTable.userId.equals(userId),
          ),
        ])..where(
          licenseQuestionTable.licenseId.equals(licenseId) &
              questionTable.categoryId.equals(categoryId),
        );

    return query.watch().map((rows) {
      final uniqueQuestions = <int, TypedResult>{};

      final groupedData = <int, List<QuestionOptionTableData>>{};
      for (final row in rows) {
        final question = row.readTable(questionTable);
        final option = row.readTable(questionOptionTable);
        groupedData.putIfAbsent(question.id, () => []).add(option);
        uniqueQuestions.putIfAbsent(question.id, () => row);
      }

      return uniqueQuestions.values.map((r) {
        final question = r.readTable(questionTable);
        final options = groupedData[question.id] ?? [];
        final status = r.readTableOrNull(questionStatusTable);
        return QuestionWithDetails(
          question: question,
          options: options,
          status: status,
        );
      }).toList();
    });
  }

  Future<void> updateQuestionStatus({
    required int userId,
    required int questionId,
    int? optionId,
    bool? isSaved,
    bool? isCorrect,
    String? note,
  }) async {
    await into(questionStatusTable).insert(
      QuestionStatusTableCompanion.insert(
        userId: userId,
        questionId: questionId,
        optionId: Value(optionId),
        isSaved: Value(isSaved ?? false),
        isCorrect: Value(isCorrect),
        note: Value(note),
        updatedAt: Value(DateTime.now()),
      ),
      onConflict: DoUpdate(
        (old) => QuestionStatusTableCompanion(
          optionId: optionId != null ? Value(optionId) : Value.absent(),
          isSaved: isSaved != null ? Value(isSaved) : Value.absent(),
          isCorrect: isCorrect != null ? Value(isCorrect) : Value.absent(),
          note: note != null ? Value(note) : Value.absent(),
          updatedAt: Value(DateTime.now()),
        ),
        target: [questionStatusTable.userId, questionStatusTable.questionId],
      ),
    );
  }

  // get questions by id list
  // get question with options
  // validate answer
}
