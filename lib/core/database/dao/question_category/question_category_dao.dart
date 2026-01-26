import 'package:drift/drift.dart';
import 'package:onthi_gplx_pro/core/database/app_database.dart';
import 'package:onthi_gplx_pro/core/database/table/question_category_table.dart';

part 'question_category_dao.g.dart';

@DriftAccessor(tables: [QuestionCategoryTable])
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

  Future<List<QuestionCategoryTableData>> getCategories() =>
      select(questionCategoryTable).get();

  Future<QuestionCategoryTableData?> getCategoryById(int id) async {
    final returnedData = await ((select(
      questionCategoryTable,
    ))..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
    return returnedData;
  }
}
