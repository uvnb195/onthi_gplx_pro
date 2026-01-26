import 'package:onthi_gplx_pro/core/database/app_database.dart';

class QuestionWithChoices {
  final QuestionTableData question;
  final List<QuestionOptionTableData> options;

  const QuestionWithChoices({required this.question, required this.options});
}
