// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_dao.dart';

// ignore_for_file: type=lint
mixin _$CategoryDaoMixin on DatabaseAccessor<AppDatabase> {
  $LicenseTableTable get licenseTable => attachedDatabase.licenseTable;
  $QuestionCategoryTableTable get questionCategoryTable =>
      attachedDatabase.questionCategoryTable;
  $LicenseCategoryTableTable get licenseCategoryTable =>
      attachedDatabase.licenseCategoryTable;
  $RuleTableTable get ruleTable => attachedDatabase.ruleTable;
  CategoryDaoManager get managers => CategoryDaoManager(this);
}

class CategoryDaoManager {
  final _$CategoryDaoMixin _db;
  CategoryDaoManager(this._db);
  $$LicenseTableTableTableManager get licenseTable =>
      $$LicenseTableTableTableManager(_db.attachedDatabase, _db.licenseTable);
  $$QuestionCategoryTableTableTableManager get questionCategoryTable =>
      $$QuestionCategoryTableTableTableManager(
        _db.attachedDatabase,
        _db.questionCategoryTable,
      );
  $$LicenseCategoryTableTableTableManager get licenseCategoryTable =>
      $$LicenseCategoryTableTableTableManager(
        _db.attachedDatabase,
        _db.licenseCategoryTable,
      );
  $$RuleTableTableTableManager get ruleTable =>
      $$RuleTableTableTableManager(_db.attachedDatabase, _db.ruleTable);
}
