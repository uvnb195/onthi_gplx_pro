import 'package:onthi_gplx_pro/core/database/app_database.dart';
import 'package:onthi_gplx_pro/features/learning/domain/entities/question_status.dart';

extension QuestionStatusMapper on QuestionStatusTableData {
  QuestionStatusEntity toEntity() {
    return QuestionStatusEntity(
      questionId: questionId,
      isCorrect: isCorrect,
      userId: userId,
      optionId: optionId,
      isSaved: isSaved,
      updatedAt: updatedAt,
      note: note,
    );
  }
}
