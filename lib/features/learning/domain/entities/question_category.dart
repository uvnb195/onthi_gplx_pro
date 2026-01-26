import 'package:equatable/equatable.dart';

class QuestionCategoryEntity extends Equatable {
  final int id;
  final String label;
  final String description;

  const QuestionCategoryEntity({
    required this.id,
    required this.label,
    required this.description,
  });

  @override
  List<Object?> get props => [id, label, description];
}
