import 'package:dart_either/src/dart_either.dart';
import 'package:onthi_gplx_pro/core/error/exceptions.dart';
import 'package:onthi_gplx_pro/core/error/failures.dart';
import 'package:onthi_gplx_pro/features/user_management/data/data_sources/local/index.dart';
import 'package:onthi_gplx_pro/features/user_management/data/models/index.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/entities/index.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/repositories/index.dart';

class LicenseRepositoryImpl implements LicenseRepository {
  final LocalLicenseDataSource _licenseDataSource;
  LicenseRepositoryImpl(this._licenseDataSource);

  @override
  Future<Either<Failure, List<LicenseEntity>>> getLicenses() async {
    try {
      final result = await _licenseDataSource.getLicenses();

      if (result.isEmpty) {
        return Left(CacheFailure('Không thể truy xuất dữ liệu GPLX'));
      }
      return Right(result.map((e) => LicenseModel.fromDrift(e)).toList());
    } on CacheException catch (e) {
      return Left(CacheFailure('Lỗi truy xuất dữ liệu $e'));
    }
  }

  @override
  Future<Either<Failure, LicenseEntity>> getLicenseById(int id) async {
    try {
      final result = await _licenseDataSource.getLicenseById(id);
      if (result == null) {
        return Left(CacheFailure('Không thể truy xuất dữ liệu GPLX'));
      }
      return Right(LicenseModel.fromDrift(result));
    } on CacheException catch (e) {
      return Left(CacheFailure('Lỗi truy xuất dữ liệu $e'));
    }
  }
}
