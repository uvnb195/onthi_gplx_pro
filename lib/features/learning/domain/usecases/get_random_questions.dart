import 'package:dart_either/dart_either.dart';
import 'package:injectable/injectable.dart';
import 'package:onthi_gplx_pro/core/error/failures.dart';
import 'package:onthi_gplx_pro/core/usecase/usecase.dart';
import 'package:onthi_gplx_pro/features/learning/domain/entities/index.dart';
import 'package:onthi_gplx_pro/features/learning/domain/repositories/question_category_repository.dart';
import 'package:onthi_gplx_pro/features/learning/domain/repositories/question_repository.dart';

class GetRandomQuestionsResult {
  final List<QuestionEntity> questions;
  final List<CategoryRuleEntity> rules;

  const GetRandomQuestionsResult({
    required this.rules,
    required this.questions,
  });
}

class GetRandomQuestionsParams {
  final int examType, licenseId;

  const GetRandomQuestionsParams({
    required this.examType,
    required this.licenseId,
  });
}

@lazySingleton
class GetRandomQuestionsUseCase
    extends UseCase<GetRandomQuestionsResult, GetRandomQuestionsParams> {
  final QuestionRepository questionRepository;
  final QuestionCategoryRepository questionCategoryRepository;

  GetRandomQuestionsUseCase({
    required this.questionRepository,
    required this.questionCategoryRepository,
  });

  @override
  Future<Either<Failure, GetRandomQuestionsResult>> call(
    GetRandomQuestionsParams params,
  ) async {
    final questionsEither = await questionRepository.getRandomQuestions(
      params.licenseId,
    );
    final rulesEither = await questionCategoryRepository.getExamRules(
      params.examType,
      params.licenseId,
    );
    return questionsEither.flatMap(
      (questions) => rulesEither.map(
        (rules) => GetRandomQuestionsResult(rules: rules, questions: questions),
      ),
    );
  }
}
