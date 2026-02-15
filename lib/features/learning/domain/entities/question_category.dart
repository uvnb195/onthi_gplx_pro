import 'package:equatable/equatable.dart';
import 'package:onthi_gplx_pro/features/learning/domain/entities/category_rule.dart';

class QuestionCategoryEntity extends Equatable {
  final int id;
  final String label;
  final String description;
  final List<CategoryRuleEntity> rules;

  const QuestionCategoryEntity({
    required this.id,
    required this.label,
    required this.description,
    this.rules = const [],
  });

  @override
  List<Object?> get props => [id, label, description, rules];
}
