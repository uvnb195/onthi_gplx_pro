import 'package:dart_either/dart_either.dart';
import 'package:injectable/injectable.dart';
import 'package:onthi_gplx_pro/core/error/failures.dart';
import 'package:onthi_gplx_pro/core/usecase/usecase.dart';
import 'package:onthi_gplx_pro/features/learning/domain/entities/question_category.dart';
import 'package:onthi_gplx_pro/features/learning/domain/repositories/question_category_repository.dart';
import 'package:onthi_gplx_pro/features/learning/domain/repositories/question_repository.dart';

class GetLicenseInfoResults {
  final int totalQuestions;
  final List<QuestionCategoryEntity> categories;

  GetLicenseInfoResults({
    required this.totalQuestions,
    required this.categories,
  });
}

@lazySingleton
class GetLicenseInfoUseCase extends UseCase<GetLicenseInfoResults, int> {
  final QuestionCategoryRepository _categoryRepository;
  final QuestionRepository _questionRepository;
  GetLicenseInfoUseCase({
    required QuestionCategoryRepository categoryRepository,
    required QuestionRepository questionRepository,
  }) : _categoryRepository = categoryRepository,
       _questionRepository = questionRepository;

  @override
  Future<Either<Failure, GetLicenseInfoResults>> call(int licenseId) async {
    final futures = await Future.wait([
      _questionRepository.getTotalQuestionCount(licenseId),
      _categoryRepository.getQuestionCategoriesByLicense(licenseId),
    ]);

    return Either.binding((e) {
      final total = e.bind(futures[0] as Either<Failure, int>);
      final cats = e.bind(
        futures[1] as Either<Failure, List<QuestionCategoryEntity>>,
      );

      return GetLicenseInfoResults(totalQuestions: total, categories: cats);
    });
  }
}
