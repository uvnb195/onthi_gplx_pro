import 'package:onthi_gplx_pro/core/database/app_database.dart';

class QuestionWithOptions {
  final QuestionTableData question;
  final List<QuestionOptionTableData> options;

  const QuestionWithOptions({required this.question, required this.options});
}
