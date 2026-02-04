part of 'learning_bloc.dart';

sealed class LearningEvent extends Equatable {
  const LearningEvent();

  @override
  List<Object?> get props => [];
}

final class LoadCategories extends LearningEvent {
  final int licenseId;
  const LoadCategories({required this.licenseId});

  @override
  List<Object> get props => [licenseId];
}

final class LoadQuestions extends LearningEvent {
  final QuestionCategoryEntity category;

  const LoadQuestions(this.category);

  @override
  List<Object?> get props => [category];
}

final class ToggleSaveQuestion extends LearningEvent {
  final bool isSaving;
  const ToggleSaveQuestion(this.isSaving);

  @override
  List<Object> get props => [isSaving];
}
