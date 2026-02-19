import 'package:drift/drift.dart';
import 'package:onthi_gplx_pro/core/database/table/index.dart';

class LearningHistoryTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId =>
      integer().references(UserTable, #id, onDelete: .cascade)();
  IntColumn get examAttemptId => integer()
      .references(ExamAttemptTable, #id, onDelete: .setNull)
      .nullable()();
  IntColumn get questionId =>
      integer().references(QuestionTable, #id, onDelete: .cascade)();
  IntColumn get selectedOptionId =>
      integer().references(QuestionOptionTable, #id)();
  BoolColumn get isCorrect => boolean()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
