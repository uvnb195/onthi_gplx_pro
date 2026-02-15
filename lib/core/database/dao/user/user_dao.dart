import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:onthi_gplx_pro/core/constants/license_type.dart';
import 'package:onthi_gplx_pro/core/database/app_database.dart';
import 'package:onthi_gplx_pro/core/database/models/user_with_license.dart';
import 'package:onthi_gplx_pro/core/database/table/license_table.dart';
import 'package:onthi_gplx_pro/core/database/table/user_table.dart';

part 'user_dao.g.dart';

@lazySingleton
@DriftAccessor(tables: [UserTable, LicenseTable])
class UserDao extends DatabaseAccessor<AppDatabase> with _$UserDaoMixin {
  UserDao(super.attachedDatabase);

  // S E E D - D A T A
  Future<void> createLicensesSeedData(List<dynamic> licensesJson) async {
    final licenseCompanions = licensesJson.map((e) {
      return LicenseTableCompanion.insert(
        code: LicenseType.fromInt(e['id'] as int),
        description: e['description'] as String,
      );
    }).toList();

    await batch(
      (batch) => batch.insertAll(
        licenseTable,
        licenseCompanions,
        mode: .insertOrReplace,
      ),
    );
  }

  // U S E R
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
        license: row.readTable(licenseTable),
      );
    });
  }

  Future<int> createUser(UserTableCompanion user) {
    // only 1 user is allowed in the app (offline mode), so we fix the id to 1
    final userWithFixedId = user.copyWith(id: const Value(1));
    return into(userTable).insert(userWithFixedId, mode: .insertOrReplace);
  }

  Future<int> deleteAllUsers() {
    return delete(userTable).go();
  }

  // L I C E N S E
  Future<List<LicenseTableData>> getAllLicenses() => select(licenseTable).get();

  Future<LicenseTableData?> getLicenseById(int id) async {
    final returnedData = await (select(
      licenseTable,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
    return returnedData;
  }
}
