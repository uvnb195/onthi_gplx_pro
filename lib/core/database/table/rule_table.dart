import 'package:drift/drift.dart';
import 'package:onthi_gplx_pro/core/constants/index.dart';
import 'package:onthi_gplx_pro/core/database/table/license_table.dart';
import 'package:onthi_gplx_pro/core/database/table/question_category_table.dart';

class RuleTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().nullable()();
  TextColumn get content => text().nullable()();
  IntColumn get level => integer().withDefault(const Constant(1))();

  // rule chỉ được phép thuộc về 1 trong 2
  // (category hoặc exam)
  // => nếu là rule của exam (lý thuyết) thì phải có licenseId
  //(bởi vì: mỗi license có 1 số lượng câu hỏi riêng)
  IntColumn get categoryId =>
      integer().references(QuestionCategoryTable, #id).nullable()();
  IntColumn get examType => intEnum<ExamType>().nullable()();
  IntColumn get licenseId =>
      integer().references(LicenseTable, #id).nullable()();
}
