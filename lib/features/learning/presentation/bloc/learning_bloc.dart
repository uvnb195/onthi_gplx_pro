import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dart_either/dart_either.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:onthi_gplx_pro/core/error/failures.dart';
import 'package:onthi_gplx_pro/features/learning/domain/entities/index.dart';
import 'package:onthi_gplx_pro/features/learning/domain/usecases/index.dart';

part 'learning_event.dart';
part 'learning_state.dart';

@lazySingleton
class LearningBloc extends Bloc<LearningEvent, LearningState> {
  final GetAllQuestionCategoriesUseCase getAllQuestionCategoriesUseCase;
  final GetLicenseInfoUseCase getLicenseInfoUseCase;
  final GetQuestionCategoriesByIdUseCase getQuestionCategoriesByIdUseCase;

  final GetRandomQuestionsUseCase getRandomQuestionsUseCase;

  final WatchQuestionsByCategoryUseCase getQuestionsByCategoryUseCase;
  final UpdateQuestionStatusUseCase updateQuestionStatusUseCase;

  LearningBloc({
    required this.getAllQuestionCategoriesUseCase,
    required this.getQuestionCategoriesByIdUseCase,
    required this.getLicenseInfoUseCase,
    required this.getRandomQuestionsUseCase,
    required this.getQuestionsByCategoryUseCase,
    required this.updateQuestionStatusUseCase,
  }) : super(LearningState(selectedCategory: null, categories: [])) {
    on<LoadCategories>(_onLoadCategories);
    on<LoadLearningQuestions>(
      _onLoadLearningQuestions,
      transformer: restartable(),
    );
    on<LoadExamQuestions>(_onLoadExamQuestions);

    on<UpdateQuestionStatus>(_onUpdateQuestionStatus);
  }

  void _onLoadCategories(
    LoadCategories event,
    Emitter<LearningState> emit,
  ) async {
    emit(state.copyWith(loading: true));
    final result = await getLicenseInfoUseCase.call(event.licenseId);

    result.fold(
      ifLeft: (error) {
        emit(state.copyWith(errorMessage: error.message, loading: false));
      },
      ifRight: (success) {
        emit(
          state.copyWith(
            categories: success.categories,
            totalQuestions: success.totalQuestions,
            loading: false,
          ),
        );
      },
    );
  }

  void _onLoadLearningQuestions(
    LoadLearningQuestions event,
    Emitter<LearningState> emit,
  ) async {
    emit(
      state.copyWith(
        loading: true,
        selectedCategory: event.category,
        questions: [],
        errorMessage: null,
      ),
    );
    await emit.forEach<Either<Failure, List<QuestionEntity>>>(
      getQuestionsByCategoryUseCase(
        WatchQuestionsByCategoryParams(
          categoryId: event.category.id,
          licenseId: event.licenseId,
        ),
      ),
      onData: (result) {
        return result.fold(
          ifLeft: (error) =>
              state.copyWith(errorMessage: error.message, loading: false),
          ifRight: (success) {
            return state.copyWith(questions: success, loading: false);
          },
        );
      },
      onError: (err, _) =>
          state.copyWith(errorMessage: err.toString(), loading: false),
    );
  }

  void _onLoadExamQuestions(
    LoadExamQuestions event,
    Emitter<LearningState> emit,
  ) async {
    emit(state.copyWith(loading: true));

    final result = await getRandomQuestionsUseCase(
      GetRandomQuestionsParams(
        examType: event.examType,
        licenseId: event.licenseId,
      ),
    );

    result.fold(
      ifLeft: (error) =>
          emit(state.copyWith(errorMessage: error.message, loading: false)),
      ifRight: (success) =>
          emit(state.copyWith(examRules: (success.rules), loading: false)),
    );
  }

  void _onUpdateQuestionStatus(
    UpdateQuestionStatus event,
    Emitter<LearningState> emit,
  ) async {
    final result = await updateQuestionStatusUseCase(event.params);

    result.fold(
      ifLeft: (failure) {
        emit(state.copyWith(errorMessage: failure.message, loading: false));
      },
      ifRight: (_) {
        emit(state.copyWith(errorMessage: null, loading: false));
      },
    );
  }
}
