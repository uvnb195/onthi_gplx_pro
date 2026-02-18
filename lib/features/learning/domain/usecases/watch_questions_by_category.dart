import 'package:dart_either/dart_either.dart';
import 'package:injectable/injectable.dart';
import 'package:onthi_gplx_pro/core/error/failures.dart';
import 'package:onthi_gplx_pro/core/usecase/usecase.dart';
import 'package:onthi_gplx_pro/features/learning/domain/entities/index.dart';
import 'package:onthi_gplx_pro/features/learning/domain/repositories/question_repository.dart';

class WatchQuestionsByCategoryParams {
  final int licenseId, categoryId;

  const WatchQuestionsByCategoryParams({
    required this.licenseId,
    required this.categoryId,
  });
}

@lazySingleton
class WatchQuestionsByCategoryUseCase
    extends
        StreamUseCase<List<QuestionEntity>, WatchQuestionsByCategoryParams> {
  final QuestionRepository _questionRepository;

  WatchQuestionsByCategoryUseCase(this._questionRepository);

  @override
  Stream<Either<Failure, List<QuestionEntity>>> call(
    WatchQuestionsByCategoryParams params,
  ) {
    return _questionRepository.watchQuestionsByCategory(
      licenseId: params.licenseId,
      categoryId: params.categoryId,
    );
  }
}
