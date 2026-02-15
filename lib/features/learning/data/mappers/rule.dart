import 'package:onthi_gplx_pro/core/database/app_database.dart';
import 'package:onthi_gplx_pro/features/learning/domain/entities/category_rule.dart';

extension CategoryRuleMapper on RuleTableData {
  CategoryRuleEntity toEntity() {
    return CategoryRuleEntity(
      categoryId: categoryId,
      examType: examType?.index,
      licenseId: licenseId,
      title: title ?? "",
      content: content ?? "",
      level: level,
    );
  }
}
