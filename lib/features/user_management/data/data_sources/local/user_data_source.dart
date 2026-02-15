import 'package:injectable/injectable.dart';
import 'package:onthi_gplx_pro/core/database/app_database.dart';
import 'package:onthi_gplx_pro/core/database/models/index.dart';

abstract class LocalUserDataSource {
  Stream<UserWithLicense?> currentUserStream();
  Future<void> clearUser();
  Future<int> createUser(UserTableCompanion user);
}

@LazySingleton(as: LocalUserDataSource)
class LocalUserDataSourceImpl implements LocalUserDataSource {
  final AppDatabase _db;

  const LocalUserDataSourceImpl(this._db);

  @override
  Future<void> clearUser() {
    return _db.userDao.deleteAllUsers();
  }

  @override
  Stream<UserWithLicense?> currentUserStream() {
    return _db.userDao.currentUserStream();
  }

  @override
  Future<int> createUser(UserTableCompanion user) {
    return _db.userDao.createUser(user);
  }
}
