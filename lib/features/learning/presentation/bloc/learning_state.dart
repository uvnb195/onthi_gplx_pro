part of 'learning_bloc.dart';

class LearningState extends Equatable {
  final QuestionCategoryEntity? selectedCategory;
  final List<QuestionCategoryEntity> categories;
  final List<QuestionEntity> questions;
  // rule for exam (theory/video_simulation)
  final List<CategoryRuleEntity> examRules;

  final bool loading;
  final String? errorMessage;

  const LearningState({
    required this.selectedCategory,
    required this.categories,
    this.questions = const [],
    this.loading = false,
    this.errorMessage,
    this.examRules = const [],
  });

  LearningState copyWith({
    QuestionCategoryEntity? selectedCategory,
    List<QuestionCategoryEntity>? categories,
    List<QuestionEntity>? questions,
    List<CategoryRuleEntity>? examRules,
    bool loading = false,
    String? errorMessage,
  }) {
    return LearningState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      categories: categories ?? this.categories,
      questions: questions ?? this.questions,
      examRules: examRules ?? this.examRules,
      loading: loading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    selectedCategory,
    categories,
    questions,
    examRules,
    loading,
    errorMessage,
  ];
}
