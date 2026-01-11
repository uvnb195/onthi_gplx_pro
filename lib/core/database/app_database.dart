import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:onthi_gplx_pro/core/database/seed_data.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/value_objects/license.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'dao/index.dart';
import 'table/index.dart';

part 'app_database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbLocation = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbLocation.path, 'app_database.sqlite'));

    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [UserTable, LicenseTable], daos: [UserDao, LicenseDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 3;

  Future<void> loadLicenseSeed() async {
    final count = await licenseTable.count().getSingle();
    if (count > 0) return;

    await batch((batch) {
      batch.insertAll(licenseTable, licenseSeedData, mode: .insertOrReplace);
    });
  }

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();

        await loadLicenseSeed();
      },
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
      },
      onUpgrade: (m, from, to) async {
        // migration db
      },
    );
  }
}
