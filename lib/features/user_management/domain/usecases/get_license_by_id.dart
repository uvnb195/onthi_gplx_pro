import 'package:dart_either/src/dart_either.dart';
import 'package:injectable/injectable.dart';
import 'package:onthi_gplx_pro/core/error/failures.dart';
import 'package:onthi_gplx_pro/core/usecase/usecase.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/entities/index.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/repositories/license_repository.dart';

@lazySingleton
class GetLicenseByIdUseCase extends UseCase<LicenseEntity, int> {
  final LicenseRepository _licenseRepository;

  GetLicenseByIdUseCase(this._licenseRepository);

  @override
  Future<Either<Failure, LicenseEntity>> call(int id) {
    return _licenseRepository.getLicenseById(id);
  }
}
