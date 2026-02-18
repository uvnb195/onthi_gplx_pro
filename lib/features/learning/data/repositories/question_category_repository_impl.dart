import 'package:dart_either/dart_either.dart';
import 'package:injectable/injectable.dart';
import 'package:onthi_gplx_pro/core/error/failures.dart';
import 'package:onthi_gplx_pro/features/learning/data/data_sources/local/category_data_source.dart';
import 'package:onthi_gplx_pro/features/learning/data/mappers/question_category_mapper.dart';
import 'package:onthi_gplx_pro/features/learning/data/mappers/rule.dart';
import 'package:onthi_gplx_pro/features/learning/domain/entities/category_rule.dart';
import 'package:onthi_gplx_pro/features/learning/domain/entities/question_category.dart';
import 'package:onthi_gplx_pro/features/learning/domain/repositories/question_category_repository.dart';

@LazySingleton(as: QuestionCategoryRepository)
class QuestionCategoryRepositoryImpl implements QuestionCategoryRepository {
  final LocalCategoryDataSource localCategoryDataSource;

  QuestionCategoryRepositoryImpl({required this.localCategoryDataSource});

  @override
  Future<Either<Failure, List<QuestionCategoryEntity>>>
  getQuestionCategories() async {
    try {
      final result = await localCategoryDataSource.getAllCategories();
      return Right(result.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(
        DatabaseFailure(
          'An error occur while getting All Question Categories: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, QuestionCategoryEntity>> getQuestionCategoryById(
    int id,
  ) async {
    try {
      final result = await localCategoryDataSource.getCategoryById(id);
      if (result == null) {
        return Left(DatabaseFailure('Not found Question Category (id: $id)'));
      }
      return Right(result.toEntity());
    } catch (e) {
      return Left(
        DatabaseFailure(
          'An error occur while getting Question Category by id ($id): ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<QuestionCategoryEntity>>>
  getQuestionCategoriesByLicense(int licenseId) async {
    try {
      final result = await localCategoryDataSource
          .getQuestionCategoriesByLicense(licenseId);
      return Right(result.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(
        DatabaseFailure(
          'An error occur while getting Question Category by License (licenseID: $licenseId): ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<CategoryRuleEntity>>> getExamRules(
    int examType,
    int licenseId,
  ) async {
    try {
      final result = await localCategoryDataSource.getExamRules(
        examType,
        licenseId,
      );
      return Right(result.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(
        DatabaseFailure(
          'An error occur while getting Exam Rules (licenseID: $licenseId, examType: $examType): ${e.toString()}',
        ),
      );
    }
  }
}
