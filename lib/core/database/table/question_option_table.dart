import 'package:drift/drift.dart';
import 'package:onthi_gplx_pro/core/database/table/question_table.dart';

class QuestionOptionTable extends Table {
  @override
  String get tableName => 'option';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get content => text()();
  IntColumn get questionId =>
      integer().references(QuestionTable, #id, onDelete: KeyAction.cascade)();
  BoolColumn get isCorrect => boolean().withDefault(const Constant(false))();
}
