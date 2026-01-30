import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:onthi_gplx_pro/core/database/app_database.dart';
import 'package:onthi_gplx_pro/core/database/table/license_table.dart';
import 'package:onthi_gplx_pro/core/extension/index.dart';

part 'license_dao.g.dart';

@DriftAccessor(tables: [LicenseTable])
@lazySingleton
class LicenseDao extends DatabaseAccessor<AppDatabase> with _$LicenseDaoMixin {
  LicenseDao(super.db);

  // S E E D - D A T A
  Future<void> createLicensesSeedData(List<dynamic> licensesJson) async {
    final licenseCompanions = licensesJson.map((e) {
      return LicenseTableCompanion.insert(
        code: LicenseTypeExt.fromString(e['code'])!,
        description: e['description'],
      );
    }).toList();

    await batch((batch) => batch.insertAll(licenseTable, licenseCompanions));
  }

  Future<List<LicenseTableData>> getLicenseList() => select(licenseTable).get();

  Future<LicenseTableData?> getLicenseById(int id) async {
    final returnedData = await (select(
      licenseTable,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
    return returnedData;
  }
}
