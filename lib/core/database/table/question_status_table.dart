import 'package:drift/drift.dart';
import 'package:onthi_gplx_pro/core/database/table/index.dart';

class QuestionStatusTable extends Table {
  IntColumn get id => integer().autoIncrement()();
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

  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<String> get customConstraints => ['UNIQUE(user_id, question_id)'];
}
