import 'package:drift/drift.dart';
import 'package:onthi_gplx_pro/core/database/app_database.dart';
import 'package:onthi_gplx_pro/core/database/table/license_table.dart';

part 'license_dao.g.dart';

@DriftAccessor(tables: [LicenseTable])
class LicenseDao extends DatabaseAccessor<AppDatabase> with _$LicenseDaoMixin {
  LicenseDao(super.db);

  Future<List<LicenseTableData>> getLicenseList() => select(licenseTable).get();

  Future<LicenseTableData?> getLicenseById(int id) async {
    final returnedData = await (select(
      licenseTable,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
    return returnedData;
  }
}
