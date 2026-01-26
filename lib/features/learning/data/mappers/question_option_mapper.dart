import 'package:onthi_gplx_pro/core/database/app_database.dart';
import 'package:onthi_gplx_pro/features/learning/domain/entities/question_option.dart';

extension QuestionOptionMapper on QuestionOptionTableData {
  QuestionOptionEntity toEntity() {
    return QuestionOptionEntity(id: id, content: content, isCorrect: isCorrect);
  }
}
