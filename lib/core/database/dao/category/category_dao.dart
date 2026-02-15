import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:onthi_gplx_pro/core/database/app_database.dart';
import 'package:onthi_gplx_pro/core/database/models/question_category_with_rules.dart';
import 'package:onthi_gplx_pro/core/database/table/index.dart';
import 'package:onthi_gplx_pro/core/extension/exam_type.dart';

part 'category_dao.g.dart';

@DriftAccessor(
  tables: [
    LicenseTable,
    LicenseCategoryTable,
    QuestionCategoryTable,
    RuleTable,
  ],
)
@lazySingleton
class CategoryDao extends DatabaseAccessor<AppDatabase>
    with _$CategoryDaoMixin {
  CategoryDao(super.attachedDatabase);

  // S E E D - D A T A

  Future<void> createCategoriesSeedData(List<dynamic> categoriesJson) async {
    await batch(
      (batch) => batch.insertAll(
        questionCategoryTable,
        categoriesJson
            .map(
              (e) => QuestionCategoryTableCompanion.insert(
                id: Value(e['id'] as int),
                label: e['label'],
                description: Value(e['description']),
              ),
            )
            .toList(),
        mode: .insertOrReplace,
      ),
    );
  }

  Future<void> createLicenseCategoriesSeedData(
    List<dynamic> licenseCategoriesJson,
  ) async {
    await batch((batch) {
      final insertions = licenseCategoriesJson.expand((e) {
        final licenseId = e['license_id'];
        List<int> questionCategories = List<int>.from(e['data']);
        if (questionCategories.isEmpty) {
          questionCategories = List.generate(8, (i) => i + 1);
        }

        return questionCategories.map(
          (e) => LicenseCategoryTableCompanion.insert(
            licenseId: licenseId as int,
            questionCategoryId: e,
          ),
        );
      }).toList();

      batch.insertAll(licenseCategoryTable, insertions, mode: .insertOrReplace);
    });
  }

  Future<void> createCategoryRulesSeedData(List<dynamic> categoryRules) async {
    await batch((batch) {
      batch.insertAll(
        ruleTable,
        categoryRules.map((e) {
          final int levelValue = (e['level'] as int?) ?? 1;
          return RuleTableCompanion.insert(
            categoryId: e['categoryId'] != null
                ? Value(e['categoryId'] as int)
                : const Value.absent(),

            licenseId: e['licenseId'] != null
                ? Value(e['licenseId'] as int)
                : const Value.absent(),

            examType: e['examType'] != null
                ? Value((e['examType'] as int?).toExamType)
                : const Value.absent(),

            title: e['title'] != null
                ? Value(e['title'] as String)
                : const Value.absent(),

            content: e['content'] != null
                ? Value(e['content'] as String)
                : const Value.absent(),

            level: Value(levelValue),
          );
        }).toList(),
      );
    });
  }

  // - - - - - - - - - - - - -
  Future<List<QuestionCategoryWithRules>> getAllCategories() async {
    final query = select(questionCategoryTable).join([
      leftOuterJoin(
        ruleTable,
        ruleTable.categoryId.equalsExp(questionCategoryTable.id),
      ),
    ]);

    final groupedData = <int, QuestionCategoryWithRules>{};

    final rows = await query.get();

    for (var row in rows) {
      final category = row.readTable(questionCategoryTable);
      final rule = row.readTableOrNull(ruleTable);
      final entry = groupedData.putIfAbsent(
        category.id,
        () => QuestionCategoryWithRules(category: category, rules: []),
      );
      if (rule != null) {
        entry.rules.add(rule);
      }
    }

    return groupedData.values.toList();
  }

  Future<QuestionCategoryWithRules?> getCategoryById(int id) async {
    final query = select(questionCategoryTable).join([
      leftOuterJoin(
        ruleTable,
        ruleTable.categoryId.equalsExp(questionCategoryTable.id),
      ),
    ])..where(questionCategoryTable.id.equals(id));

    final rows = await query.get();

    if (rows.isEmpty) return null;

    final category = rows.first.readTable(questionCategoryTable);
    final List<RuleTableData> rules = [];

    for (var row in rows) {
      final rule = row.readTableOrNull(ruleTable);

      if (rule != null) rules.add(rule);
    }

    return QuestionCategoryWithRules(category: category, rules: rules);
  }

  Future<List<QuestionCategoryWithRules>> getQuestionCategoriesByLicense(
    int licenseId,
  ) async {
    final query = select(questionCategoryTable).join([
      innerJoin(
        licenseCategoryTable,
        licenseCategoryTable.questionCategoryId.equalsExp(
          questionCategoryTable.id,
        ),
      ),
      leftOuterJoin(
        ruleTable,
        ruleTable.categoryId.equalsExp(questionCategoryTable.id),
      ),
    ])..where(licenseCategoryTable.licenseId.equals(licenseId));

    final rows = await query.get();

    final groupedData = <int, QuestionCategoryWithRules>{};

    for (var row in rows) {
      final category = row.readTable(questionCategoryTable);
      final rule = row.readTableOrNull(ruleTable);
      final entry = groupedData.putIfAbsent(
        category.id,
        () => QuestionCategoryWithRules(category: category, rules: []),
      );
      if (rule != null) {
        entry.rules.add(rule);
      }
    }

    return groupedData.values.toList();
  }

  Future<List<RuleTableData>> getExamRules(int examType, int licenseId) async {
    final query = db.select(ruleTable)
      ..where((tbl) {
        final isRightExam = tbl.examType.equals(examType);
        Expression<bool> isRightLicense;
        // examType == 0 => theoryExam, need specialized licenseId
        if (examType == 0) {
          isRightLicense = tbl.licenseId.equals(licenseId);
        } else {
          isRightLicense = Constant(true);
        }

        return isRightExam & isRightLicense;
      });

    final results = await query.get();

    return results;
  }
}
