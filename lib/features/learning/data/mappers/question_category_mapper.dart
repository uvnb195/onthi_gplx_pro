import 'package:onthi_gplx_pro/core/database/models/question_category_with_rules.dart';
import 'package:onthi_gplx_pro/features/learning/data/mappers/rule.dart';
import 'package:onthi_gplx_pro/features/learning/domain/entities/index.dart';

extension QuestionCategoryMapper on QuestionCategoryWithRules {
  QuestionCategoryEntity toEntity() {
    return QuestionCategoryEntity(
      id: category.id,
      label: category.label,
      description: category.description ?? "",
      rules: rules.map((e) => e.toEntity()).toList(),
    );
  }
}
