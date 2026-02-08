import 'package:dart_either/dart_either.dart';
import 'package:injectable/injectable.dart';
import 'package:onthi_gplx_pro/core/error/failures.dart';
import 'package:onthi_gplx_pro/core/usecase/usecase.dart';
import 'package:onthi_gplx_pro/features/learning/domain/entities/index.dart';
import 'package:onthi_gplx_pro/features/learning/domain/repositories/question_repository.dart';

class GetQuestionByCategoryParams {
  final int categoryId;
  final int licenseId;
  const GetQuestionByCategoryParams({
    required this.categoryId,
    required this.licenseId,
  });
}

@lazySingleton
class GetQuestionByCategoryUseCase
    extends UseCase<List<QuestionEntity>, GetQuestionByCategoryParams> {
  final QuestionRepository _questionRepository;
  GetQuestionByCategoryUseCase(this._questionRepository);

  @override
  Future<Either<Failure, List<QuestionEntity>>> call(
    GetQuestionByCategoryParams params,
  ) {
    return _questionRepository.getQuestionsByCategory(
      params.categoryId,
      params.licenseId,
    );
  }
}
