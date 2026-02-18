import 'package:onthi_gplx_pro/core/database/app_database.dart';

class QuestionWithDetails {
  final QuestionTableData question;
  final List<QuestionOptionTableData> options;
  final QuestionStatusTableData? status;

  const QuestionWithDetails({
    required this.question,
    required this.options,
    this.status,
  });
}
