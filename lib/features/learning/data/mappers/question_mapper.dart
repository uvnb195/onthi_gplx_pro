import 'package:onthi_gplx_pro/core/database/app_database.dart';
import 'package:onthi_gplx_pro/features/learning/domain/entities/question.dart';
import 'package:onthi_gplx_pro/features/learning/domain/entities/question_option.dart';
import 'package:onthi_gplx_pro/features/learning/domain/entities/question_status.dart';

extension QuestionMapper on QuestionTableData {
  QuestionEntity toEntity({
    required List<QuestionOptionEntity> options,
    QuestionStatusEntity? status,
  }) {
    return QuestionEntity(
      id: id,
      content: content,
      explanation: explanation ?? "",
      isCritical: isCritical,
      categoryId: categoryId,
      options: options,
      status: status,
    );
  }
}
