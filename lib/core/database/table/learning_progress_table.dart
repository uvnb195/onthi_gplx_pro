import 'package:drift/drift.dart';
import 'package:onthi_gplx_pro/core/database/table/license_table.dart';
import 'package:onthi_gplx_pro/core/database/table/question_category_table.dart';
import 'package:onthi_gplx_pro/core/database/table/user_table.dart';

class LearningProgressTable extends Table {
  @override
  String get tableName => 'learning_progress';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId =>
      integer().references(UserTable, #id, onDelete: .cascade)();
  IntColumn get licenseId =>
      integer().references(LicenseTable, #id, onDelete: .noAction)();

  // [questionCategoryId] nullable because this table can track progress by [License] or by [QuestionCategory]
  IntColumn get questionCategoryId => integer()
      .references(QuestionCategoryTable, #id, onDelete: .noAction)
      .nullable()();

  IntColumn get totalQuestions => integer().withDefault(const Constant(0))();

  // by  questions
  IntColumn get answeredQuestions => integer().withDefault(const Constant(0))();
  IntColumn get correctAnswers => integer()();

  // by attempts
  IntColumn get totalAttempts => integer().withDefault(const Constant(0))();
  IntColumn get correctAttempts => integer().withDefault(const Constant(0))();

  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
