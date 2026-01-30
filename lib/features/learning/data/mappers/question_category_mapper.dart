import 'package:onthi_gplx_pro/core/database/app_database.dart';
import 'package:onthi_gplx_pro/features/learning/domain/entities/index.dart';

extension QuestionCategoryMapper on QuestionCategoryTableData {
  QuestionCategoryEntity toEntity() {
    return QuestionCategoryEntity(
      id: id,
      label: label,
      description: description ?? "",
    );
  }
}
