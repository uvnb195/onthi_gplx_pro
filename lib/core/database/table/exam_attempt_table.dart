import 'package:drift/drift.dart';
import 'package:onthi_gplx_pro/core/database/table/index.dart';

class ExamAttemptTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId =>
      integer().references(UserTable, #id, onDelete: .cascade)();
  IntColumn get score => integer()();
  IntColumn get totalQuestions => integer()();
  IntColumn get correctCount => integer()();
  BoolColumn get isPassed => boolean()();
  TextColumn get failedReason => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
