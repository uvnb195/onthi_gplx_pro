import 'package:onthi_gplx_pro/core/database/app_database.dart';
import 'package:onthi_gplx_pro/core/database/dao/index.dart';

abstract class LocalUserDataSource {
  Stream<UserWithLicense?> currentUserStream();
  Future<void> clearUser();
  Future<void> insertUser();
}

class LocalUserDataSourceImpl implements LocalUserDataSource {
  final AppDatabase _db;

  const LocalUserDataSourceImpl(this._db);

  @override
  Future<void> clearUser() {
    // TODO: implement clearUser
    throw UnimplementedError();
  }

  @override
  Stream<UserWithLicense?> currentUserStream() {
    return _db.userDao.currentUserStream();
  }

  @override
  Future<void> insertUser() {
    // TODO: implement insertUser
    throw UnimplementedError();
  }
}
