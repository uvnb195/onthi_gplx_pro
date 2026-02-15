import 'package:onthi_gplx_pro/core/constants/exam_type.dart';

extension ExamTypeHelper on int? {
  ExamType? get toExamType {
    if (this == null) return null;
    if (this! >= 0 && this! < ExamType.values.length) {
      return ExamType.values[this!];
    }

    return null;
  }
}
