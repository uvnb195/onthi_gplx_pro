import 'package:dart_either/dart_either.dart';
import 'package:onthi_gplx_pro/core/error/failures.dart';
import 'package:onthi_gplx_pro/features/learning/domain/entities/question.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/value_objects/index.dart';

abstract class QuestionRepository {
  Future<Either<Failure, List<QuestionEntity>>> getQuestionsByCategory(
    int categoryId,
  );

  Future<Either<Failure, List<QuestionEntity>>> getQuestionsByExam(int examId);

  Future<Either<Failure, List<QuestionEntity>>> getRandomQuestionsForLicense(
    LicenseType licenseType,
  );

  Future<Either<Failure, List<QuestionEntity>>> getCriticalQuestions();

  Future<Either<Failure, List<QuestionEntity>>> getSavedQuestions({
    int userId = 1,
  });
}
