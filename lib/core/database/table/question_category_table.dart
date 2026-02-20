import 'package:drift/drift.dart';

class QuestionCategoryTable extends Table {
  @override
  String get tableName => 'category';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get label => text()();
  TextColumn get description => text().nullable()();
}
