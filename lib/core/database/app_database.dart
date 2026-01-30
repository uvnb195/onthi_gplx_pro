import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/services.dart';
import 'package:onthi_gplx_pro/core/database/dao/index.dart';
import 'package:onthi_gplx_pro/core/database/table/index.dart';
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
    LicenseQuestionCategoryTable,
    QuestionCategoryTable,
    QuestionTable,
    QuestionOptionTable,
  ],
  daos: [UserDao, LicenseDao, QuestionCategoryDao, QuestionDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();

        final rawQuestionCategories = await rootBundle.loadString(
          'assets/data/question_categories.json',
        );
        final rawQuestionOptions = await rootBundle.loadString(
          'assets/data/question_options.json',
        );
        final rawQuestions = await rootBundle.loadString(
          'assets/data/questions.json',
        );
        final String rawLicenses = await rootBundle.loadString(
          'assets/data/licenses.json',
        );

        final List<dynamic> categoriesJson = json.decode(rawQuestionCategories);
        final List<dynamic> optionsJson = json.decode(rawQuestionOptions);
        final List<dynamic> questionsJson = json.decode(rawQuestions);
        final List<dynamic> licensesJson = json.decode(rawLicenses);

        await licenseDao.createLicensesSeedData(licensesJson);
        await questionCategoryDao.createCategoriesSeedData(categoriesJson);
        await questionDao.createQuestionsSeedData(
          optionsJson: optionsJson,
          questionsJson: questionsJson,
        );
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
