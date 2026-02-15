import 'package:onthi_gplx_pro/core/database/app_database.dart';

class QuestionCategoryWithRules {
  final QuestionCategoryTableData category;
  final List<RuleTableData> rules;

  const QuestionCategoryWithRules({
    required this.category,
    required this.rules,
  });
}
