import 'package:drift/drift.dart';

class QuestionCategoryTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get label => text()();
  TextColumn get description => text().nullable()();
}
