import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:onthi_gplx_pro/core/database/app_database.dart';
import 'package:onthi_gplx_pro/core/database/dao/index.dart';
import 'package:onthi_gplx_pro/core/extension/exam_type.dart';

import '../../../helpers/db_helper.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase db;
  late QuestionCategoryDao questionCategoryDao;

  setUp(() async {
    db = setUpTestDb();
    questionCategoryDao = db.questionCategoryDao;
  });

  tearDown(() async {
    await db.close();
  });

  group('Test Question Category Dao', () {
    test('check seed data inserted', () async {
      final result = await questionCategoryDao.getAllCategories();

      expect(result.length, greaterThan(0));
      expect(result.length, 6);
      expect(
        result.any((element) => element.category.label == 'Hệ thống Biển báo'),
        isTrue,
      );
    });

    test('license_category seed data must be inserted ', () async {
      final allResults = await db.select(db.licenseCategoryTable).get();
      final licenseId1 = 1;
      final licenseId2 = 3;
      final resultsOfLicenseId1 = await (db.select(
        db.licenseCategoryTable,
      )..where((tbl) => tbl.licenseId.equals(licenseId1))).get();
      final resultsOfLicenseId2 = await (db.select(
        db.licenseCategoryTable,
      )..where((tbl) => tbl.licenseId.equals(licenseId2))).get();

      expect(
        allResults.length,
        6 * 15 - 2,
        reason: '15 licenses, 6 chapters, A and A1 doesn\'t learn chapter 4',
      );
      expect(resultsOfLicenseId1.length, 5);
      print(resultsOfLicenseId1);
      expect(resultsOfLicenseId2.length, 6);
      print(resultsOfLicenseId2);
    });

    test('rules seed data must be inserted ', () async {
      final allResults = await db.select(db.ruleTable).get();

      expect(allResults.length, greaterThan(0));
      print(allResults.length);
    });

    test('check exam rules', () async {
      final theoryExam = ExamType.theory;
      final simulationExam = ExamType.simulation;
      final licenseId = 1;
      print(theoryExam.index);
      final theoryResults =
          await (db.select(db.ruleTable)..where((tbl) {
                final isRightExam = tbl.examType.equals(theoryExam.index);
                final isRightLicense = tbl.licenseId.equals(licenseId);

                return isRightExam & isRightLicense;
              }))
              .get();
      final simulationResults =
          await (db.select(db.ruleTable)..where((tbl) {
                final isRightExam = tbl.examType.equals(simulationExam.index);

                return isRightExam;
              }))
              .get();

      expect(theoryResults.length, greaterThan(0));
      expect(simulationResults.length, greaterThan(0));
    });
  });
}
