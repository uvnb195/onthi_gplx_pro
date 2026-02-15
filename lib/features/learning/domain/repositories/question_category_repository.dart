import 'package:dart_either/dart_either.dart';
import 'package:onthi_gplx_pro/core/error/failures.dart';
import 'package:onthi_gplx_pro/features/learning/domain/entities/category_rule.dart';
import 'package:onthi_gplx_pro/features/learning/domain/entities/question_category.dart';

abstract class QuestionCategoryRepository {
  Future<Either<Failure, List<QuestionCategoryEntity>>> getQuestionCategories();

  Future<Either<Failure, QuestionCategoryEntity>> getQuestionCategoryById(
    int id,
  );

  Future<Either<Failure, List<QuestionCategoryEntity>>>
  getQuestionCategoriesByLicense(int licenseId);

  Future<Either<Failure, List<CategoryRuleEntity>>> getExamRules(
    int examType,
    int licenseId,
  );
}
