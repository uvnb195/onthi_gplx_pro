import 'package:drift/drift.dart';
import 'package:onthi_gplx_pro/core/database/table/question_category_table.dart';

class QuestionTable extends Table {
  @override
  String get tableName => 'question';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get imageId => text().nullable()();
  TextColumn get content => text()();
  TextColumn get explanation => text().nullable()();
  BoolColumn get isCritical => boolean().withDefault(const Constant(false))();
  IntColumn get categoryId =>
      integer().references(QuestionCategoryTable, #id, onDelete: .cascade)();
}
