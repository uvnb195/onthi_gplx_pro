// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_dao.dart';

// ignore_for_file: type=lint
mixin _$QuestionDaoMixin on DatabaseAccessor<AppDatabase> {
  $LicenseTableTable get licenseTable => attachedDatabase.licenseTable;
  $QuestionCategoryTableTable get questionCategoryTable =>
      attachedDatabase.questionCategoryTable;
  $QuestionTableTable get questionTable => attachedDatabase.questionTable;
  $LicenseQuestionTableTable get licenseQuestionTable =>
      attachedDatabase.licenseQuestionTable;
  $QuestionOptionTableTable get questionOptionTable =>
      attachedDatabase.questionOptionTable;
  $UserTableTable get userTable => attachedDatabase.userTable;
  $QuestionStatusTableTable get questionStatusTable =>
      attachedDatabase.questionStatusTable;
  $LearningProgressTableTable get learningProgressTable =>
      attachedDatabase.learningProgressTable;
  QuestionDaoManager get managers => QuestionDaoManager(this);
}

class QuestionDaoManager {
  final _$QuestionDaoMixin _db;
  QuestionDaoManager(this._db);
  $$LicenseTableTableTableManager get licenseTable =>
      $$LicenseTableTableTableManager(_db.attachedDatabase, _db.licenseTable);
  $$QuestionCategoryTableTableTableManager get questionCategoryTable =>
      $$QuestionCategoryTableTableTableManager(
        _db.attachedDatabase,
        _db.questionCategoryTable,
      );
  $$QuestionTableTableTableManager get questionTable =>
      $$QuestionTableTableTableManager(_db.attachedDatabase, _db.questionTable);
  $$LicenseQuestionTableTableTableManager get licenseQuestionTable =>
      $$LicenseQuestionTableTableTableManager(
        _db.attachedDatabase,
        _db.licenseQuestionTable,
      );
  $$QuestionOptionTableTableTableManager get questionOptionTable =>
      $$QuestionOptionTableTableTableManager(
        _db.attachedDatabase,
        _db.questionOptionTable,
      );
  $$UserTableTableTableManager get userTable =>
      $$UserTableTableTableManager(_db.attachedDatabase, _db.userTable);
  $$QuestionStatusTableTableTableManager get questionStatusTable =>
      $$QuestionStatusTableTableTableManager(
        _db.attachedDatabase,
        _db.questionStatusTable,
      );
  $$LearningProgressTableTableTableManager get learningProgressTable =>
      $$LearningProgressTableTableTableManager(
        _db.attachedDatabase,
        _db.learningProgressTable,
      );
}
