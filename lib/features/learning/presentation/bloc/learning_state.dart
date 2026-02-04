part of 'learning_bloc.dart';

class LearningState extends Equatable {
  // categoryId == 0 => critical questions
  // categoryId == -1 => saved question
  // exam attempt should be use other flag
  final QuestionCategoryEntity? selectedCategory;
  final List<QuestionCategoryEntity> categories;
  final List<QuestionEntity> questions;

  final bool loading;
  final String? errorMessage;

  const LearningState({
    required this.selectedCategory,
    required this.categories,
    this.questions = const [],
    this.loading = false,
    this.errorMessage,
  });

  LearningState copyWith({
    QuestionCategoryEntity? selectedCategory,
    List<QuestionCategoryEntity>? categories,
    List<QuestionEntity>? questions,
    bool loading = false,
    String? errorMessage,
  }) {
    return LearningState(
      selectedCategory: selectedCategory,
      categories: categories ?? this.categories,
      questions: questions ?? this.questions,
      loading: loading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    selectedCategory,
    categories,
    questions,
    loading,
    errorMessage,
  ];
}
