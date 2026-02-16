import 'package:injectable/injectable.dart';
import 'package:onthi_gplx_pro/core/database/dao/question/question_dao.dart';
import 'package:onthi_gplx_pro/core/database/models/question_with_details.dart';

abstract class LocalQuestionDataSource {
  Stream<List<QuestionWithDetails>> watchQuestionsByCategory({
    required int categoryId,
    required int licenseId,
    required int userId,
  });

  Future<void> updateQuestionStatus({
    required int questionId,
    required int userId,
    int? optionId,
    bool? isCorrect,
    String? note,
    bool? isSaved,
  });
}

@LazySingleton(as: LocalQuestionDataSource)
class LocalQuestionDataSourceImpl implements LocalQuestionDataSource {
  final QuestionDao _questionDao;

  LocalQuestionDataSourceImpl(this._questionDao);

  @override
  Stream<List<QuestionWithDetails>> watchQuestionsByCategory({
    required int categoryId,
    required int licenseId,
    required int userId,
  }) {
    return _questionDao.watchQuestionsByCategory(
      categoryId: categoryId,
      licenseId: licenseId,
      userId: userId,
    );
  }

  @override
  Future<void> updateQuestionStatus({
    required int questionId,
    required int userId,
    int? optionId,
    bool? isCorrect,
    String? note,
    bool? isSaved,
  }) {
    return _questionDao.updateQuestionStatus(
      questionId: questionId,
      userId: userId,
      optionId: optionId,
      isCorrect: isCorrect,
      note: note,
      isSaved: isSaved,
    );
  }
}
