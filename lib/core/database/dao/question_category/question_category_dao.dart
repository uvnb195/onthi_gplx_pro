import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:onthi_gplx_pro/core/database/app_database.dart';
import 'package:onthi_gplx_pro/core/database/table/index.dart';

part 'question_category_dao.g.dart';

@DriftAccessor(
  tables: [LicenseTable, LicenseQuestionCategoryTable, QuestionCategoryTable],
)
@lazySingleton
class QuestionCategoryDao extends DatabaseAccessor<AppDatabase>
    with _$QuestionCategoryDaoMixin {
  QuestionCategoryDao(super.attachedDatabase);

  Future<void> createCategoriesSeedData(List<dynamic> categoriesJson) async {
    await batch(
      (batch) => batch.insertAll(
        questionCategoryTable,
        categoriesJson
            .map(
              (e) => QuestionCategoryTableCompanion.insert(
                label: e['label'],
                description: Value(e['description']),
              ),
            )
            .toList(),
        mode: .insertOrReplace,
      ),
    );
  }

  Future<List<QuestionCategoryTableData>> getAllCategories() =>
      select(questionCategoryTable).get();

  Future<QuestionCategoryTableData?> getCategoryById(int id) async {
    final returnedData = await ((select(
      questionCategoryTable,
    ))..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
    return returnedData;
  }

  Future<List<QuestionCategoryTableData>> getQuestionCategoriesByLicense(
    int licenseId,
  ) async {
    final query = select(questionCategoryTable).join([
      innerJoin(
        licenseQuestionCategoryTable,
        licenseQuestionCategoryTable.questionCategoryId.equalsExp(
          questionCategoryTable.id,
        ),
      ),
    ])..where(licenseQuestionCategoryTable.licenseId.equals(licenseId));

    final rows = await query.get();
    return rows.map((row) => row.readTable(questionCategoryTable)).toList();
  }
}
