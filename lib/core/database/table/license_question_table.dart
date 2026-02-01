import 'package:drift/drift.dart';
import 'package:onthi_gplx_pro/core/database/table/index.dart';

class LicenseQuestionTable extends Table {
  IntColumn get licenseId =>
      integer().references(LicenseTable, #id, onDelete: .cascade)();
  IntColumn get questionId =>
      integer().references(QuestionTable, #id, onDelete: .cascade)();

  @override
  Set<Column<Object>>? get primaryKey => {licenseId, questionId};
}
