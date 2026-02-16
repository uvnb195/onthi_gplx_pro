import 'package:dart_either/dart_either.dart';
import 'package:injectable/injectable.dart';
import 'package:onthi_gplx_pro/core/error/failures.dart';
import 'package:onthi_gplx_pro/core/usecase/usecase.dart';
import 'package:onthi_gplx_pro/features/learning/domain/repositories/question_repository.dart';

class UpdateQuestionStatusParams {
  final int questionId;
  final int userId;
  final int? optionId;
  final bool? isCorrect;
  final String? note;
  final bool? isSaved;

  UpdateQuestionStatusParams({
    required this.questionId,
    required this.userId,
    this.optionId,
    this.isCorrect,
    this.note,
    this.isSaved,
  });
}

@lazySingleton
class UpdateQuestionStatusUseCase
    extends UseCase<void, UpdateQuestionStatusParams> {
  final QuestionRepository _questionRepository;

  UpdateQuestionStatusUseCase(this._questionRepository);

  @override
  Future<Either<Failure, void>> call(UpdateQuestionStatusParams params) {
    return _questionRepository.updateQuestionStatus(
      questionId: params.questionId,
      userId: params.userId,
      optionId: params.optionId,
      isCorrect: params.isCorrect,
      note: params.note,
      isSaved: params.isSaved,
    );
  }
}
