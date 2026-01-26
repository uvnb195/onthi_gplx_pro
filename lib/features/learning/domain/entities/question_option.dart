import 'package:equatable/equatable.dart';

class QuestionOptionEntity extends Equatable {
  final int id;
  final String content;
  final bool isCorrect;
  const QuestionOptionEntity({
    required this.id,
    required this.content,
    required this.isCorrect,
  });

  @override
  List<Object?> get props => [id, content, isCorrect];
}
