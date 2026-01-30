part of 'learning_bloc.dart';

class LearningState extends Equatable {
  final int? selectedCategoryId;
  final List<QuestionCategoryEntity> categories;

  final bool loading;
  final String? errorMessage;

  const LearningState({
    required this.selectedCategoryId,
    required this.categories,
    this.loading = false,
    this.errorMessage,
  });

  LearningState copyWith({
    int? selectedCategoryId,
    List<QuestionCategoryEntity>? categories,
    bool loading = false,
    String? errorMessage,
  }) {
    return LearningState(
      selectedCategoryId: selectedCategoryId,
      categories: categories ?? this.categories,
      loading: loading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    selectedCategoryId,
    categories,
    loading,
    errorMessage,
  ];
}
