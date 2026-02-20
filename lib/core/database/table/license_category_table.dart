import 'package:drift/drift.dart';
import 'package:onthi_gplx_pro/core/database/table/index.dart';

class LicenseCategoryTable extends Table {
  @override
  String get tableName => 'license_category';

  IntColumn get licenseId =>
      integer().references(LicenseTable, #id, onDelete: .cascade)();
  IntColumn get questionCategoryId =>
      integer().references(QuestionCategoryTable, #id, onDelete: .cascade)();

  @override
  Set<Column<Object>>? get primaryKey => {licenseId, questionCategoryId};
}
