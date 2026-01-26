import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/services.dart';
import 'package:onthi_gplx_pro/core/database/app_database.dart';
import 'package:onthi_gplx_pro/core/database/table/question_category_table.dart';

part 'category_dao.g.dart';

@DriftAccessor(tables: [QuestionCategoryTable])
class QuestionCategoryDao extends DatabaseAccessor<AppDatabase>
    with _$CategoryDaoMixin {
  QuestionCategoryDao(super.attachedDatabase);

  Future<void> createCategoriesSeedData() async {
    final jsonString = await rootBundle.loadString(
      'assets/data/question_categories.json',
    );

    final List<dynamic> categoriesJson = json.decode(jsonString);

    await batch(
      (batch) => batch.insertAll(
        questionCategoryTable,
        categoriesJson
            .map(
              (e) => CategoryTableCompanion.insert(
                label: e['label'],
                description: e['description'],
              ),
            )
            .toList(),
      ),
    );
  }

  Future<List<CategoryTableData>> getCategories() =>
      select(categoryTable).get();

  Future<CategoryTableData?> getCategoryById(int id) async {
    final returnedData = await ((select(
      categoryTable,
    ))..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
    return returnedData;
  }
}
