import 'package:dart_either/dart_either.dart';
import 'package:injectable/injectable.dart';
import 'package:onthi_gplx_pro/core/database/dao/index.dart';
import 'package:onthi_gplx_pro/core/error/failures.dart';
import 'package:onthi_gplx_pro/features/learning/data/mappers/question_category_mapper.dart';
import 'package:onthi_gplx_pro/features/learning/domain/entities/question_category.dart';
import 'package:onthi_gplx_pro/features/learning/domain/repositories/question_category_repository.dart';

@LazySingleton(as: QuestionCategoryRepository)
class QuestionCategoryRepositoryImpl implements QuestionCategoryRepository {
  final QuestionCategoryDao questionCategoryDao;
  final QuestionDao questionDao;

  QuestionCategoryRepositoryImpl({
    required this.questionCategoryDao,
    required this.questionDao,
  });

  @override
  Future<Either<Failure, List<QuestionCategoryEntity>>>
  getQuestionCategories() async {
    try {
      final result = await questionCategoryDao.getAllCategories();
      print('Total categories: ${result.length}');
      for (var c in result) {
        print('Category: ${c.id} - ${c.label}');
      }
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
      final result = await questionCategoryDao.getCategoryById(id);
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
      final result = await questionCategoryDao.getQuestionCategoriesByLicense(
        licenseId,
      );
      return Right(result.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(
        DatabaseFailure(
          'An error occur while getting Question Category by License (licenseID: $licenseId): ${e.toString()}',
        ),
      );
    }
  }
}
