import 'package:equatable/equatable.dart';

class QuestionStatusEntity extends Equatable {
  final int id;
  final int userId;
  final int questionId;
  final int? optionId;
  final bool? isCorrect;
  final bool isSaved;
  final String? note;
  final DateTime updatedAt;

  const QuestionStatusEntity({
    required this.id,
    required this.userId,
    required this.questionId,
    required this.optionId,
    required this.isCorrect,
    required this.isSaved,
    this.note,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    userId,
    questionId,
    optionId,
    isSaved,
    isCorrect,
    note,
    updatedAt,
  ];
}
