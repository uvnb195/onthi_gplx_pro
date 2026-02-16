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

final class LoadLearningQuestions extends LearningEvent {
  final QuestionCategoryEntity category;
  final int licenseId;

  const LoadLearningQuestions({
    required this.category,
    required this.licenseId,
  });

  @override
  List<Object?> get props => [category];
}

final class LoadExamQuestions extends LearningEvent {
  final int examType;
  final int licenseId;

  const LoadExamQuestions({required this.licenseId, required this.examType});

  @override
  List<Object?> get props => [licenseId, examType];
}

final class UpdateQuestionStatus extends LearningEvent {
  final UpdateQuestionStatusParams params;
  const UpdateQuestionStatus(this.params);

  @override
  List<Object> get props => [params];
}
