import 'package:onthi_gplx_pro/core/database/app_database.dart';
import 'package:onthi_gplx_pro/features/user_management/data/data_sources/local_user_data_source.dart';
import 'package:onthi_gplx_pro/features/user_management/data/models/user_model.dart';

class LocalUserDataSourceImpl implements LocalUserDataSource {
  final AppDatabase _db;

  const LocalUserDataSourceImpl(this._db);

  @override
  Future<void> clearUser() {
    // TODO: implement clearUser
    throw UnimplementedError();
  }

  @override
  Future<UserModel?> getCurrentUser() {
    return _db.userDao.getCurrentUser();
  }

  @override
  Future<void> insertUser() {
    // TODO: implement insertUser
    throw UnimplementedError();
  }
}
