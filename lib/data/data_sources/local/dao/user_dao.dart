import 'package:drift/drift.dart';
import 'package:onthi_gplx_pro/data/data_sources/local/app_database.dart';
import 'package:onthi_gplx_pro/data/data_sources/local/tables/user/user_table.dart';
import 'package:onthi_gplx_pro/data/models/user_model.dart';

part 'user_dao.g.dart';

@DriftAccessor(tables: [UserTable])
class UserDao extends DatabaseAccessor<AppDatabase> with _$UserDaoMixin {
  UserDao(super.attachedDatabase);

  Future<UserModel?> getCurrentUser() async {
    final returnedData = await select(userTable).getSingleOrNull();
    return returnedData != null ? UserModel.fromDrift(returnedData) : null;
  }

  Future<void> createUser(UserTableCompanion user) {
    return into(userTable).insert(user);
  }
}
