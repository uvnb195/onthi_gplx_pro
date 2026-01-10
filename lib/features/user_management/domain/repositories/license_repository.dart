import 'package:dart_either/dart_either.dart';
import 'package:onthi_gplx_pro/core/error/failures.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/entities/index.dart';

abstract class LicenseRepository {
  Future<Either<Failure, List<LicenseEntity>>> getLicenses();

  Future<Either<Failure, LicenseEntity>> getLicenseById(int id);
}
