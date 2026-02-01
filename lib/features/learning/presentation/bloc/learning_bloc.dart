import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:onthi_gplx_pro/features/learning/domain/entities/index.dart';
import 'package:onthi_gplx_pro/features/learning/domain/usecases/get_all_question_categories.dart';
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

  LearningBloc({
    required this.getAllQuestionCategoriesUseCase,
    required this.getQuestionCategoriesByIdUseCase,
    required this.getQuestionCategoriesByLicenseUseCase,
  }) : super(LearningState(selectedCategoryId: null, categories: [])) {
    on<LoadCategories>(_onLearningLoading);
    on<ToggleSaveQuestion>(_onLearningLoadFail);
  }

  void _onLearningLoading(
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

  void _onLearningLoadFail(
    ToggleSaveQuestion event,
    Emitter<LearningState> emit,
  ) {}
}
