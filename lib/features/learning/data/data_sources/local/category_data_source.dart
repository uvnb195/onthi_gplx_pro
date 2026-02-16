import 'package:injectable/injectable.dart';
import 'package:onthi_gplx_pro/core/database/app_database.dart';
import 'package:onthi_gplx_pro/core/database/dao/category/category_dao.dart';
import 'package:onthi_gplx_pro/core/database/models/index.dart';

abstract class LocalCategoryDataSource {
  Future<List<QuestionCategoryWithRules>> getAllCategories();
  Future<QuestionCategoryWithRules?> getCategoryById(int id);
  Future<List<QuestionCategoryWithRules>> getQuestionCategoriesByLicense(
    int licenseId,
  );

  Future<List<RuleTableData>> getExamRules(int examType, int licenseId);
}

@LazySingleton(as: LocalCategoryDataSource)
class LocalCategoryDataSourceImpl implements LocalCategoryDataSource {
  final CategoryDao _categoryDao;

  LocalCategoryDataSourceImpl(this._categoryDao);

  @override
  Future<List<QuestionCategoryWithRules>> getAllCategories() {
    return _categoryDao.getAllCategories();
  }

  @override
  Future<QuestionCategoryWithRules?> getCategoryById(int id) {
    return _categoryDao.getCategoryById(id);
  }

  @override
  Future<List<QuestionCategoryWithRules>> getQuestionCategoriesByLicense(
    int licenseId,
  ) {
    return _categoryDao.getQuestionCategoriesByLicense(licenseId);
  }

  @override
  Future<List<RuleTableData>> getExamRules(int examType, int licenseId) {
    return _categoryDao.getExamRules(examType, licenseId);
  }
}
