import 'package:dart_either/src/dart_either.dart';
import 'package:injectable/injectable.dart';
import 'package:onthi_gplx_pro/core/error/failures.dart';
import 'package:onthi_gplx_pro/core/usecase/usecase.dart';
import 'package:onthi_gplx_pro/features/learning/domain/entities/index.dart';
import 'package:onthi_gplx_pro/features/learning/domain/repositories/question_repository.dart';

@lazySingleton
class GetQuestionByCategoryUseCase extends UseCase<List<QuestionEntity>, int> {
  final QuestionRepository _questionRepository;
  GetQuestionByCategoryUseCase(this._questionRepository);

  @override
  Future<Either<Failure, List<QuestionEntity>>> call(int categoryId) {
    return _questionRepository.getQuestionsByCategory(categoryId);
  }
}
