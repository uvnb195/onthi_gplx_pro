import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/services.dart';
import 'package:onthi_gplx_pro/core/constants/index.dart';
import 'package:onthi_gplx_pro/core/database/dao/index.dart';
import 'package:onthi_gplx_pro/core/database/table/index.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

const String _trgUpsertLearningProgressByCategoryOnInsert = """
CREATE TRIGGER IF NOT EXISTS trg_upsert_learning_progress_by_category_on_insert
after insert on question_status
BEGIN
  insert into learning_progress(
    user_id,
    license_id,
    question_category_id,
    total_questions,
    answered_questions,
    correct_answers,
    total_attempts,
    correct_attempts,
    updated_at
  )
  select 
    new.user_id,
    lq.license_id,
    q.category_id,
    (SELECT COUNT(*) FROM question q_inner JOIN license_question lq_inner ON q_inner.id = lq_inner.question_id
      WHERE 
        lq_inner.license_id = lq.license_id
        AND 
        q_inner.category_id = q.category_id
    ),
    1, -- init answered_questions
    ifnull(NEW.is_correct,0), -- init correct_answers
    1,
    ifnull(NEW.is_correct,0), -- init correct_attempts
    STRFTIME('%Y-%m-%d %H:%M:%S', 'now')
    
  from 
    question q
  join license_question lq on lq.question_id = q.id
  where q.id = NEW.question_id
  
  ON CONFLICT(user_id, license_id, question_category_id)
  DO UPDATE SET
    answered_questions = answered_questions + ifnull(NEW.is_new,0),
    correct_answers = correct_answers + 
      (CASE WHEN NEW.is_new = 1 
        AND NEW.is_correct = 1 THEN 1
        ELSE 0
      END),
    total_attempts = total_attempts +(case when new.is_new is not null then 1 else 0 end),
    correct_attempts = correct_attempts + ifnull(NEW.is_correct,0),
    updated_at = STRFTIME('%Y-%m-%d %H:%M:%S', 'now');
  END;
""";

const String _trgUpsertLearningProgressByLicenseOnInsert = """
CREATE TRIGGER IF NOT EXISTS trg_upsert_learning_progress_by_license_on_insert
after insert on question_status
BEGIN
  insert into learning_progress(
    user_id,
    license_id,
    question_category_id,
    total_questions,
    answered_questions,
    correct_answers,
    total_attempts,
    correct_attempts,
    updated_at
  )
  select 
    new.user_id,
    lq.license_id,
    null,
    (case when lq.license_id in (1,2) then 250
      when lq.license_id = 3 then 300 
      else 600
    end),
    1, -- init answered_questions
    ifnull(NEW.is_correct,0), -- init correct_answers
    1,
    ifnull(NEW.is_correct,0), -- init correct_attempts
    STRFTIME('%Y-%m-%d %H:%M:%S', 'now')
    
  from 
    question q
  join license_question lq on lq.question_id = q.id
  where q.id = NEW.question_id
  
  ON CONFLICT(user_id, license_id)
  DO UPDATE SET
    answered_questions = answered_questions + ifnull(NEW.is_new,0),
    correct_answers = correct_answers + 
      (CASE WHEN NEW.is_new = 1 
        AND NEW.is_correct = 1 THEN 1
        ELSE 0
      END),
    total_attempts = total_attempts +(case when new.is_new is not null then 1 else 0 end),
    correct_attempts = correct_attempts + ifnull(NEW.is_correct,0),
    updated_at = STRFTIME('%Y-%m-%d %H:%M:%S', 'now');
  END;
""";

const String _trgUpdateLearningProgressByCategoryOnUpdate = """
CREATE TRIGGER IF NOT EXISTS trg_update_learning_progress_by_category
AFTER UPDATE of is_correct,is_new ON question_status
BEGIN
  UPDATE learning_progress
  SET
    answered_questions = answered_questions + ifnull(NEW.is_new,0),
    correct_answers = correct_answers + (
      CASE 
        WHEN OLD.is_new IS NULL AND NEW.is_new = 1 AND NEW.is_correct = 1 THEN 1
        WHEN OLD.is_new IS NOT NULL THEN (IFNULL(NEW.is_correct, 0) - IFNULL(OLD.is_correct, 0))
        ELSE 0 
      END),
    total_attempts = total_attempts + (case when new.is_new is not null then 1 else 0 end),
    correct_attempts = correct_attempts + ifnull(NEW.is_correct,0),
    updated_at = STRFTIME('%Y-%m-%d %H:%M:%S', 'now')
  WHERE user_id = NEW.user_id 
    AND license_id IN (SELECT license_id FROM license_question WHERE question_id = NEW.question_id)
    AND question_category_id = (SELECT category_id FROM question WHERE id = NEW.question_id);
  END;
""";

const String _trgUpdateLearningProgressByLicenseOnUpdate = """
CREATE TRIGGER IF NOT EXISTS trg_update_learning_progress_by_license
AFTER UPDATE of is_correct,is_new ON question_status
BEGIN
  UPDATE learning_progress
  SET
    answered_questions = answered_questions + ifnull(NEW.is_new,0),
    correct_answers = correct_answers + (
      CASE 
        WHEN OLD.is_new IS NULL AND NEW.is_new = 1 AND NEW.is_correct = 1 THEN 1
        WHEN OLD.is_new IS NOT NULL THEN (IFNULL(NEW.is_correct, 0) - IFNULL(OLD.is_correct, 0))
        ELSE 0 
      END),
    total_attempts = total_attempts + (case when new.is_new is not null then 1 else 0 end),
    correct_attempts = correct_attempts + ifnull(NEW.is_correct,0),
    updated_at = STRFTIME('%Y-%m-%d %H:%M:%S', 'now')
  WHERE user_id = NEW.user_id 
    AND license_id IN (SELECT license_id FROM license_question WHERE question_id = NEW.question_id)
    AND question_category_id is null;
  END;
""";

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
    QuestionStatusTable,
    LearningProgressTable,
    ExamAttemptTable,
    LearningHistoryTable,
  ],
  daos: [UserDao, CategoryDao, QuestionDao],
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

          // I N I T I A L - S E E D - D A T A
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

          await userDao.createLicensesSeedData(licensesJson);
          await categoryDao.createCategoriesSeedData(categoriesJson);
          await questionDao.createQuestionsSeedData(
            optionsJson: optionsJson,
            questionsJson: questionsJson,
          );
          await questionDao.createLicenseQuestionsSeedData(
            licenseQuestionsJson,
          );
          await categoryDao.createLicenseCategoriesSeedData(
            licenseCategoriesJson,
          );
          await categoryDao.createCategoryRulesSeedData(rulesJson);

          // C R E A T E - T R I G G E R
          await Future.wait([
            customStatement(_trgUpsertLearningProgressByCategoryOnInsert),
            customStatement(_trgUpsertLearningProgressByLicenseOnInsert),
            customStatement(_trgUpdateLearningProgressByCategoryOnUpdate),
            customStatement(_trgUpdateLearningProgressByLicenseOnUpdate),
          ]);

          // nên tạo trigger set is_new flag trong question_status về false khi update (insert bỏ qua)
        } catch (e) {
          print("Error: $e");
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
