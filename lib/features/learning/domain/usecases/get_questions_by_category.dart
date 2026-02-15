import 'package:dart_either/src/dart_either.dart';
import 'package:injectable/injectable.dart';
import 'package:onthi_gplx_pro/core/error/failures.dart';
import 'package:onthi_gplx_pro/core/usecase/usecase.dart';
import 'package:onthi_gplx_pro/features/learning/domain/entities/index.dart';
import 'package:onthi_gplx_pro/features/learning/domain/repositories/question_repository.dart';

class GetQuestionsByCategoryParams {
  final licenseId, categoryId;

  const GetQuestionsByCategoryParams({
    required this.licenseId,
    required this.categoryId,
  });
}

@lazySingleton
class GetQuestionsByCategoryUseCase
    extends UseCase<List<QuestionEntity>, GetQuestionsByCategoryParams> {
  final QuestionRepository _questionRepository;

  GetQuestionsByCategoryUseCase(this._questionRepository);

  @override
  Future<Either<Failure, List<QuestionEntity>>> call(
    GetQuestionsByCategoryParams params,
  ) {
    return _questionRepository.getQuestionsByCategory(
      licenseId: params.licenseId,
      categoryId: params.categoryId,
    );
  }
}
