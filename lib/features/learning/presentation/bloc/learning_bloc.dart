import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:onthi_gplx_pro/features/learning/domain/entities/category_rule.dart';
import 'package:onthi_gplx_pro/features/learning/domain/entities/index.dart';
import 'package:onthi_gplx_pro/features/learning/domain/usecases/get_all_question_categories.dart';
import 'package:onthi_gplx_pro/features/learning/domain/usecases/get_question_by_category.dart';
import 'package:onthi_gplx_pro/features/learning/domain/usecases/get_question_categories_by_license.dart';
import 'package:onthi_gplx_pro/features/learning/domain/usecases/get_question_category_by_id.dart';
import 'package:onthi_gplx_pro/features/learning/domain/usecases/get_random_questions.dart';

part 'learning_event.dart';
part 'learning_state.dart';

@lazySingleton
class LearningBloc extends Bloc<LearningEvent, LearningState> {
  final GetAllQuestionCategoriesUseCase getAllQuestionCategoriesUseCase;
  final GetQuestionCategoriesByLicenseUseCase
  getQuestionCategoriesByLicenseUseCase;
  final GetQuestionCategoriesByIdUseCase getQuestionCategoriesByIdUseCase;

  final GetRandomQuestionsUseCase getRandomQuestionsUseCase;

  final GetQuestionByCategoryUseCase getQuestionByCategoryUseCase;

  LearningBloc({
    required this.getAllQuestionCategoriesUseCase,
    required this.getQuestionCategoriesByIdUseCase,
    required this.getQuestionCategoriesByLicenseUseCase,
    required this.getRandomQuestionsUseCase,
    required this.getQuestionByCategoryUseCase,
  }) : super(LearningState(selectedCategory: null, categories: [])) {
    on<LoadCategories>(_onLoadCategories);
    on<LoadLearningQuestions>(_onLoadLearningQuestions);
    on<LoadExamQuestions>(_onLoadExamQuestions);

    on<ToggleSaveQuestion>(_onToggleSaveQuestion);
  }

  void _onLoadCategories(
    LoadCategories event,
    Emitter<LearningState> emit,
  ) async {
    emit(state.copyWith(loading: true));
    final result = await getQuestionCategoriesByLicenseUseCase.call(
      event.licenseId,
    );

    result.fold(
      ifLeft: (error) {
        emit(state.copyWith(errorMessage: error.message));
      },
      ifRight: (success) {
        emit(state.copyWith(categories: success));
      },
    );
  }

  void _onLoadLearningQuestions(
    LoadLearningQuestions event,
    Emitter<LearningState> emit,
  ) async {
    emit(state.copyWith(loading: true, selectedCategory: event.category));
    final result = await getQuestionByCategoryUseCase(
      GetQuestionByCategoryParams(
        categoryId: event.category.id,
        licenseId: event.licenseId,
      ),
    );

    result.fold(
      ifLeft: (error) => emit(state.copyWith(errorMessage: error.message)),
      ifRight: (success) => emit(state.copyWith(questions: success)),
    );
  }

  void _onLoadExamQuestions(
    LoadExamQuestions event,
    Emitter<LearningState> emit,
  ) async {
    print('LOAD EXAM QUESTION: ${event.examType}');
    emit(state.copyWith(loading: true));

    final result = await getRandomQuestionsUseCase(
      GetRandomQuestionsParams(
        examType: event.examType,
        licenseId: event.licenseId,
      ),
    );

    result.fold(
      ifLeft: (error) => emit(state.copyWith(errorMessage: error.message)),
      ifRight: (success) => emit(state.copyWith(examRules: (success.rules))),
    );
  }

  void _onToggleSaveQuestion(
    ToggleSaveQuestion event,
    Emitter<LearningState> emit,
  ) {}
}
