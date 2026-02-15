import 'package:dart_either/src/dart_either.dart';
import 'package:injectable/injectable.dart';
import 'package:onthi_gplx_pro/core/error/failures.dart';
import 'package:onthi_gplx_pro/core/usecase/usecase.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/entities/index.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/repositories/license_repository.dart';

@lazySingleton
class GetLicensesUseCase extends UseCase<List<LicenseEntity>, NoParams> {
  final LicenseRepository _licenseRepository;

  GetLicensesUseCase(this._licenseRepository);

  @override
  Future<Either<Failure, List<LicenseEntity>>> call(NoParams params) {
    return _licenseRepository.getLicenses();
  }
}
