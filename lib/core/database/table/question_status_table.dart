import 'package:drift/drift.dart';
import 'package:onthi_gplx_pro/core/database/table/index.dart';

class QuestionStatusTable extends Table {
  @override
  String get tableName => 'question_status';
  IntColumn get userId =>
      integer().references(UserTable, #id, onDelete: KeyAction.cascade)();

  IntColumn get questionId =>
      integer().references(QuestionTable, #id, onDelete: .noAction)();
  IntColumn get optionId => integer().nullable().references(
    QuestionOptionTable,
    #id,
    onDelete: .noAction,
  )();

  BoolColumn get isCorrect => boolean().nullable()();
  TextColumn get note => text().nullable()();
  BoolColumn get isSaved => boolean().withDefault(const Constant(false))();

  BoolColumn get isNew => boolean().nullable()();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  // TODO: implement primaryKey
  Set<Column<Object>>? get primaryKey => {userId, questionId};
}
