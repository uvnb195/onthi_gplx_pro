part of 'learning_bloc.dart';

class LearningState extends Equatable {
  final QuestionCategoryEntity? selectedCategory;
  final List<QuestionCategoryEntity> categories;
  final int totalQuestions;
  final List<QuestionEntity> questions;
  // rule for exam (theory/video_simulation)
  final List<CategoryRuleEntity> examRules;

  final bool loading;
  final String? errorMessage;

  const LearningState({
    required this.selectedCategory,
    required this.categories,
    this.totalQuestions = 0,
    this.questions = const [],
    this.loading = false,
    this.errorMessage,
    this.examRules = const [],
  });

  LearningState copyWith({
    QuestionCategoryEntity? selectedCategory,
    List<QuestionCategoryEntity>? categories,
    int? totalQuestions,
    List<QuestionEntity>? questions,
    List<CategoryRuleEntity>? examRules,
    bool? loading,
    String? errorMessage,
  }) {
    return LearningState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      categories: categories ?? this.categories,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      questions: questions ?? this.questions,
      examRules: examRules ?? this.examRules,
      loading: loading ?? this.loading,
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
