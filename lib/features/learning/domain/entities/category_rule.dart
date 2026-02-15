import 'package:equatable/equatable.dart';

class CategoryRuleEntity extends Equatable {
  final int? categoryId;
  final int? examType;
  final int? licenseId;
  final String title, content;
  final int level;

  const CategoryRuleEntity({
    this.categoryId,
    this.examType,
    this.licenseId,
    required this.title,
    required this.content,
    this.level = 0,
  });

  @override
  List<Object?> get props => [
    categoryId,
    examType,
    licenseId,
    title,
    content,
    level,
  ];
}
