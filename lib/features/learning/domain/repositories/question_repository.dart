import 'package:dart_either/dart_either.dart';
import 'package:onthi_gplx_pro/core/error/failures.dart';
import 'package:onthi_gplx_pro/features/learning/domain/entities/question.dart';

abstract class QuestionRepository {
  Future<Either<Failure, int>> getTotalQuestionCount(int licenseId);

  Stream<Either<Failure, List<QuestionEntity>>> watchQuestionsByCategory({
    required int categoryId,
    required int licenseId,
  });

  Future<Either<Failure, void>> updateQuestionStatus({
    required int questionId,
    required int userId,
    int? optionId,
    bool? isCorrect,
    String? note,
    bool? isSaved,
  });

  Future<Either<Failure, List<QuestionEntity>>> getQuestionsByExam(int examId);

  Future<Either<Failure, List<QuestionEntity>>> getRandomQuestions(
    int licenseId,
  );

  Future<Either<Failure, List<QuestionEntity>>> getSavedQuestions({
    int userId = 1,
  });
}
