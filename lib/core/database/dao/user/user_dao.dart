import 'package:drift/drift.dart';
import 'package:onthi_gplx_pro/core/database/app_database.dart';
import 'package:onthi_gplx_pro/core/database/table/license_table.dart';
import 'package:onthi_gplx_pro/core/database/table/user_table.dart';

part 'user_dao.g.dart';

@DriftAccessor(tables: [UserTable, LicenseTable])
class UserDao extends DatabaseAccessor<AppDatabase> with _$UserDaoMixin {
  UserDao(super.attachedDatabase);

  Stream<UserWithLicense?> currentUserStream() {
    final userId = 1;
    final query = select(userTable).join([
      leftOuterJoin(
        licenseTable,
        licenseTable.id.equalsExp(userTable.licenseId),
      ),
    ])..where(userTable.id.equals(userId));
    return query.watchSingleOrNull().map((row) {
      if (row == null) return null;
      return UserWithLicense(
        user: row.readTable(userTable),
        license: row.readTableOrNull(licenseTable),
      );
    });
  }

  Future<int> createUser(UserTableCompanion user) {
    final userWithFixedId = user.copyWith(id: const Value(1));
    return into(userTable).insert(userWithFixedId, mode: .insertOrReplace);
  }
}

class UserWithLicense {
  final UserTableData user;
  final LicenseTableData? license;

  const UserWithLicense({required this.user, this.license});
}
