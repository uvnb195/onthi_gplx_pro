import 'package:dart_either/src/dart_either.dart';
import 'package:injectable/injectable.dart';
import 'package:onthi_gplx_pro/core/database/dao/index.dart';
import 'package:onthi_gplx_pro/core/error/failures.dart';
import 'package:onthi_gplx_pro/features/learning/data/mappers/question_mapper.dart';
import 'package:onthi_gplx_pro/features/learning/data/mappers/question_option_mapper.dart';
import 'package:onthi_gplx_pro/features/learning/domain/entities/question.dart';
import 'package:onthi_gplx_pro/features/learning/domain/repositories/question_repository.dart';

@LazySingleton(as: QuestionRepository)
class QuestionRepositoryImpl implements QuestionRepository {
  final QuestionDao _questionDao;

  QuestionRepositoryImpl(this._questionDao);

  @override
  Future<Either<Failure, List<QuestionEntity>>> getCriticalQuestions() {
    // TODO: implement getCriticalQuestions
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<QuestionEntity>>> getQuestionsByCategory({
    required int categoryId,
    required int licenseId,
  }) async {
    try {
      final returnedDatas = await _questionDao.getQuestionsByCategory(
        categoryId: categoryId,
        licenseId: categoryId,
      );

      return Right(
        returnedDatas.map((e) {
          final question = e.question;
          final options = e.options;
          return question.toEntity(
            options: options.map((e) => e.toEntity()).toList(),
          );
        }).toList(),
      );
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<QuestionEntity>>> getQuestionsByExam(int examId) {
    // TODO: implement getQuestionsByExam
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<QuestionEntity>>> getRandomQuestions(
    int licenseId,
  ) async {
    try {
      return Right([]);
    } catch (e) {
      return Left(DatabaseFailure(""));
    }
  }

  @override
  Future<Either<Failure, List<QuestionEntity>>> getSavedQuestions({
    int userId = 1,
  }) {
    // TODO: implement getSavedQuestions
    throw UnimplementedError();
  }
}
