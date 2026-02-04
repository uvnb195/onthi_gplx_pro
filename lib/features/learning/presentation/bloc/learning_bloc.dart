import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:onthi_gplx_pro/features/learning/domain/entities/index.dart';
import 'package:onthi_gplx_pro/features/learning/domain/usecases/get_all_question_categories.dart';
import 'package:onthi_gplx_pro/features/learning/domain/usecases/get_question_by_category.dart';
import 'package:onthi_gplx_pro/features/learning/domain/usecases/get_question_categories_by_license.dart';
import 'package:onthi_gplx_pro/features/learning/domain/usecases/get_question_category_by_id.dart';

part 'learning_event.dart';
part 'learning_state.dart';

@injectable
class LearningBloc extends Bloc<LearningEvent, LearningState> {
  final GetAllQuestionCategoriesUseCase getAllQuestionCategoriesUseCase;
  final GetQuestionCategoriesByLicenseUseCase
  getQuestionCategoriesByLicenseUseCase;
  final GetQuestionCategoriesByIdUseCase getQuestionCategoriesByIdUseCase;

  final GetQuestionByCategoryUseCase getQuestionByCategoryUseCase;

  LearningBloc({
    required this.getAllQuestionCategoriesUseCase,
    required this.getQuestionCategoriesByIdUseCase,
    required this.getQuestionCategoriesByLicenseUseCase,
    required this.getQuestionByCategoryUseCase,
  }) : super(LearningState(selectedCategory: null, categories: [])) {
    on<LoadCategories>(_onLoadCategories);
    on<LoadQuestions>(_onLoadQuestions);
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
      ifRight: (success) => emit(state.copyWith(categories: success)),
    );
  }

  void _onLoadQuestions(
    LoadQuestions event,
    Emitter<LearningState> emit,
  ) async {
    emit(state.copyWith(loading: true, selectedCategory: event.category));
    if (event.category.id >= 3) {
      final result = await getQuestionByCategoryUseCase(event.category.id);

      result.fold(
        ifLeft: (error) => emit(state.copyWith(errorMessage: error.message)),
        ifRight: (success) => emit(state.copyWith(questions: success)),
      );
    }
  }

  void _onToggleSaveQuestion(
    ToggleSaveQuestion event,
    Emitter<LearningState> emit,
  ) {}
}
