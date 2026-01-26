import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/services.dart';
import 'package:onthi_gplx_pro/core/database/app_database.dart';
import 'package:onthi_gplx_pro/core/database/table/license_table.dart';

part 'license_dao.g.dart';

@DriftAccessor(tables: [LicenseTable])
class LicenseDao extends DatabaseAccessor<AppDatabase> with _$LicenseDaoMixin {
  LicenseDao(super.db);

  // S E E D - D A T A
  Future<void> createLicensesSeedData() async {
    final String jsonString = await rootBundle.loadString(
      'assets/data/licenses.json',
    );
    final List<dynamic> licenseJsonList = json.decode(jsonString);
    final licenseCompanions = licenseJsonList
        .map(
          (e) => LicenseTableCompanion.insert(
            code: e['code'],
            description: e['description'],
          ),
        )
        .toList();

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
