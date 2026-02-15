import 'package:drift/drift.dart';
import 'package:onthi_gplx_pro/core/database/table/index.dart';

class QuestionStatusTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId =>
      integer().references(UserTable, #id, onDelete: KeyAction.cascade)();

  IntColumn get questionId =>
      integer().references(QuestionTable, #id, onDelete: .noAction)();
  IntColumn get optionId =>
      integer().references(QuestionOptionTable, #id, onDelete: .noAction)();
  BoolColumn get isCorrect => boolean()();

  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
