import 'dart:io';

import 'package:drift/drift.dart';
import 'package:onthi_gplx_pro/core/database/daos/user_dao.dart';
import 'package:drift/native.dart';
import 'package:drift/drift.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/entities/license/license_type.dart';
import 'package:path_provider/path_provider.dart';
import 'package:onthi_gplx_pro/core/database/tables/user_table.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbLocation = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbLocation.path, 'app_database.sqlite'));

    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [UserTable], daos: [UserDao])
class AppDatabase extends _$AppDatabase {
  static AppDatabase? _instance;

  AppDatabase._internal() : super(_openConnection());

  factory AppDatabase() {
    _instance ??= AppDatabase._internal();
    return _instance!;
  }

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();
      },
      // onUpgrade: (m, from, to) {
      //   // migration
      // },
    );
  }
}
