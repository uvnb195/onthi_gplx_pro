import 'package:injectable/injectable.dart';
import 'package:onthi_gplx_pro/core/database/app_database.dart';
import 'package:onthi_gplx_pro/core/error/exceptions.dart';

abstract class LocalLicenseDataSource {
  Future<List<LicenseTableData>> getLicenses();
  Future<LicenseTableData?> getLicenseById(int id);
}

@LazySingleton(as: LocalLicenseDataSource)
class LocalLicenseDataSourceImpl implements LocalLicenseDataSource {
  final AppDatabase _db;
  LocalLicenseDataSourceImpl(this._db);

  @override
  Future<LicenseTableData?> getLicenseById(int id) async {
    try {
      return await _db.licenseDao.getLicenseById(id);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<List<LicenseTableData>> getLicenses() async {
    try {
      return await _db.licenseDao.getLicenseList();
    } catch (e) {
      throw CacheException();
    }
  }
}
