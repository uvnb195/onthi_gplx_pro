import 'package:dart_either/src/dart_either.dart';
import 'package:injectable/injectable.dart';
import 'package:onthi_gplx_pro/core/error/failures.dart';
import 'package:onthi_gplx_pro/features/learning/data/data_sources/local/question_data_source.dart';
import 'package:onthi_gplx_pro/features/learning/data/mappers/question_mapper.dart';
import 'package:onthi_gplx_pro/features/learning/data/mappers/question_option_mapper.dart';
import 'package:onthi_gplx_pro/features/learning/data/mappers/question_status_mapper.dart';
import 'package:onthi_gplx_pro/features/learning/domain/entities/question.dart';
import 'package:onthi_gplx_pro/features/learning/domain/repositories/question_repository.dart';

@LazySingleton(as: QuestionRepository)
class QuestionRepositoryImpl implements QuestionRepository {
  final LocalQuestionDataSource _localQuestionDataSource;

  QuestionRepositoryImpl(this._localQuestionDataSource);

  @override
  Stream<Either<Failure, List<QuestionEntity>>> watchQuestionsByCategory({
    required int categoryId,
    required int licenseId,
  }) {
    return _localQuestionDataSource
        .watchQuestionsByCategory(
          categoryId: categoryId,
          licenseId: licenseId,
          userId: 1,
        )
        .map<Either<Failure, List<QuestionEntity>>>((rows) {
          try {
            return Right(
              rows.map((r) {
                final question = r.question;
                final options = r.options
                    .where((o) => o.questionId == question.id)
                    .toList();
                final status = r.status;
                return question.toEntity(
                  status: status?.toEntity(),
                  options: options.map((e) => e.toEntity()).toList(),
                );
              }).toList(),
            );
          } catch (e) {
            return Left(
              DatabaseFailure("Error mapping questions: ${e.toString()}"),
            );
          }
        })
        .handleError((error) {
          return Left(
            DatabaseFailure(
              "Database error on watchQuestionsByCategory: ${error.toString()}",
            ),
          );
        });
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

  @override
  Future<Either<Failure, int>> updateQuestionStatus({
    required int questionId,
    required int userId,
    int? optionId,
    bool? isCorrect,
    String? note,
    bool? isSaved,
  }) async {
    try {
      final result = await _localQuestionDataSource.updateQuestionStatus(
        questionId: questionId,
        userId: userId,
        optionId: optionId,
        isCorrect: isCorrect,
        note: note,
        isSaved: isSaved,
      );

      return Right(result);
    } catch (e) {
      return Left(
        DatabaseFailure("Lỗi cập nhật trạng thái câu hỏi: ${e.toString()}"),
      );
    }
  }

  @override
  Future<Either<Failure, int>> getTotalQuestionCount(int licenseId) async {
    try {
      final count = await _localQuestionDataSource.getTotalQuestionCount(
        licenseId,
      );
      return Right(count);
    } catch (e) {
      return Left(
        DatabaseFailure(
          "Error while getting total question count: ${e.toString()}",
        ),
      );
    }
  }
}
