import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/services.dart';
import 'package:onthi_gplx_pro/core/database/dao/index.dart';
import 'package:onthi_gplx_pro/core/database/table/index.dart';
import 'package:onthi_gplx_pro/core/database/table/rule_table.dart';
import 'package:onthi_gplx_pro/core/extension/exam_type.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/value_objects/license.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbLocation = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbLocation.path, 'app_database.sqlite'));

    return NativeDatabase(file);
  });
}

@DriftDatabase(
  tables: [
    UserTable,
    LicenseTable,
    LicenseCategoryTable,
    QuestionCategoryTable,
    RuleTable,
    LicenseQuestionTable,
    QuestionTable,
    QuestionOptionTable,
  ],
  daos: [UserDao, LicenseDao, QuestionCategoryDao, QuestionDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 6;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        try {
          await m.createAll();

          final seedDatas = await Future.wait([
            rootBundle.loadString('assets/data/question_categories.json'),
            rootBundle.loadString('assets/data/question_options.json'),
            rootBundle.loadString('assets/data/questions.json'),
            rootBundle.loadString('assets/data/licenses.json'),
            rootBundle.loadString('assets/data/license_questions.json'),
            rootBundle.loadString('assets/data/license_categories.json'),
            rootBundle.loadString('assets/data/question_category_rules.json'),
          ]);

          final List<dynamic> categoriesJson = json.decode(seedDatas[0]);
          final List<dynamic> optionsJson = json.decode(seedDatas[1]);
          final List<dynamic> questionsJson = json.decode(seedDatas[2]);
          final List<dynamic> licensesJson = json.decode(seedDatas[3]);
          final List<dynamic> licenseQuestionsJson = json.decode(seedDatas[4]);
          final List<dynamic> licenseCategoriesJson = json.decode(seedDatas[5]);
          final rulesJson = json.decode(seedDatas[6]);

          await licenseDao.createLicensesSeedData(licensesJson);
          await questionCategoryDao.createCategoriesSeedData(categoriesJson);
          await questionDao.createQuestionsSeedData(
            optionsJson: optionsJson,
            questionsJson: questionsJson,
          );
          await questionDao.createLicenseQuestionsSeedData(
            licenseQuestionsJson,
          );
          await questionCategoryDao.createLicenseCategoriesSeedData(
            licenseCategoriesJson,
          );
          await questionCategoryDao.createCategoryRulesSeedData(rulesJson);
        } catch (e) {
          print("LỖI ĐÂY RỒI: $e");
        }
      },
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
      },
      onUpgrade: (m, from, to) async {
        // migration db
      },
    );
  }
}
