import 'package:dart_either/dart_either.dart';
import 'package:injectable/injectable.dart';
import 'package:onthi_gplx_pro/core/error/failures.dart';
import 'package:onthi_gplx_pro/core/usecase/usecase.dart';
import 'package:onthi_gplx_pro/features/learning/domain/entities/question_category.dart';
import 'package:onthi_gplx_pro/features/learning/domain/repositories/question_category_repository.dart';

@lazySingleton
class GetQuestionCategoriesByLicenseUseCase
    extends UseCase<List<QuestionCategoryEntity>, int> {
  final QuestionCategoryRepository _categoryRepository;
  GetQuestionCategoriesByLicenseUseCase(this._categoryRepository);

  @override
  Future<Either<Failure, List<QuestionCategoryEntity>>> call(int licenseId) {
    return _categoryRepository.getQuestionCategoriesByLicense(licenseId);
  }
}
