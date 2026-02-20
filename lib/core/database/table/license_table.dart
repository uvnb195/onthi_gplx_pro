import 'package:drift/drift.dart';
import 'package:onthi_gplx_pro/core/constants/license_type.dart';

class LicenseTable extends Table {
  @override
  String get tableName => 'license';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get code => textEnum<LicenseType>().withLength(min: 1, max: 3)();
  TextColumn get description => text()();
}
