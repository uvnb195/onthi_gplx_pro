import 'package:dart_either/src/dart_either.dart';
import 'package:injectable/injectable.dart';
import 'package:onthi_gplx_pro/core/error/failures.dart';
import 'package:onthi_gplx_pro/core/usecase/usecase.dart';
import 'package:onthi_gplx_pro/features/learning/domain/entities/question_category.dart';
import 'package:onthi_gplx_pro/features/learning/domain/repositories/question_category_repository.dart';

@lazySingleton
class GetAllQuestionCategoriesUseCase
    extends UseCase<List<QuestionCategoryEntity>, NoParams> {
  final QuestionCategoryRepository _categoryRepository;
  GetAllQuestionCategoriesUseCase(this._categoryRepository);

  @override
  Future<Either<Failure, List<QuestionCategoryEntity>>> call(
    NoParams noParams,
  ) {
    return _categoryRepository.getQuestionCategories();
  }
}
