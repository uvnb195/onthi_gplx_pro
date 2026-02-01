import 'package:flutter_test/flutter_test.dart';
import 'package:onthi_gplx_pro/core/database/app_database.dart';

import '../../../helpers/db_helper.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase db;

  setUp(() async {
    db = setUpTestDb();
  });

  tearDown(() async {
    await db.close();
  });

  group('Test Question Dao and Question Option Dao', () {
    test('check questions seed data inserted', () async {
      final questionResults = await db.select(db.questionTable).get();
      final criticalQuestions = questionResults
          .where((element) => element.isCritical == true)
          .toList();

      expect(questionResults.length, 600);
      expect(
        questionResults.any(
          (element) =>
              element.content ==
              'Xe nào phải nhường đường trong trường hợp này?',
        ),
        isTrue,
      );
      expect(
        questionResults
            .where((element) => element.categoryId == 3)
            .toList()
            .length,
        58,
      );
      expect(criticalQuestions.length, 60);
    });
    test('check options seed data inserted', () async {
      final optionResults = await db.select(db.questionOptionTable).get();

      expect(optionResults.length, greaterThan(0));
      expect(
        optionResults
            .where((element) => element.questionId == 600)
            .toList()
            .length,
        3,
      );
    });

    test('every question must have only 1 right answer', () async {
      final questionResults = await db.select(db.questionTable).get();

      for (var question in questionResults) {
        final correctOptions =
            await (db.select(db.questionOptionTable)
                  ..where((tbl) => tbl.questionId.equals(question.id))
                  ..where((tbl) => tbl.isCorrect.equals(true)))
                .get();

        expect(
          correctOptions.length,
          1,
          reason:
              'Question #${question.id} not have the right qty of correct answer',
        );
      }
    });

    test('make sure license_question_table have right seed datas', () async {
      final a1Questions = await (db.select(
        db.licenseQuestionTable,
      )..where((tbl) => tbl.licenseId.equals(1))).get();
      final aQuestions = await (db.select(
        db.licenseQuestionTable,
      )..where((tbl) => tbl.licenseId.equals(2))).get();
      final b1Questions = await (db.select(
        db.licenseQuestionTable,
      )..where((tbl) => tbl.licenseId.equals(3))).get();
      // all others GPLX will learn all (600questions)

      expect(a1Questions.length, 250, reason: 'A1 should have 250 questions');
      expect(
        aQuestions.length,
        250,
        reason: 'A should be exactly same with A1',
      );
      expect(b1Questions.length, 300, reason: 'B1 should have 300 questions');
    });
  });
}
