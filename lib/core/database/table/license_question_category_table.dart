import 'package:drift/drift.dart';
import 'package:onthi_gplx_pro/core/database/table/index.dart';

class LicenseQuestionCategoryTable extends Table {
  IntColumn get licenseId =>
      integer().references(LicenseTable, #id, onDelete: .cascade)();
  IntColumn get questionCategoryId =>
      integer().references(QuestionCategoryTable, #id, onDelete: .cascade)();
}
