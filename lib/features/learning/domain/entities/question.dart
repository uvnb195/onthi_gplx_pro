import 'package:equatable/equatable.dart';
import 'package:onthi_gplx_pro/features/learning/domain/entities/question_option.dart';
import 'package:onthi_gplx_pro/features/learning/domain/entities/question_status.dart';

class QuestionEntity extends Equatable {
  final int id;
  final String? imageId;
  final String content;
  final String explanation;
  final bool isCritical;
  final int categoryId;
  final List<QuestionOptionEntity> options;
  final QuestionStatusEntity? status;

  const QuestionEntity({
    required this.id,
    this.imageId,
    required this.content,
    required this.explanation,
    required this.isCritical,
    required this.categoryId,
    required this.options,
    this.status,
  });

  @override
  List<Object?> get props => [
    id,
    imageId,
    content,
    explanation,
    isCritical,
    categoryId,
    options,
    status,
  ];
}
