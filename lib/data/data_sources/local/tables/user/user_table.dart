import 'package:drift/drift.dart';
import 'package:onthi_gplx_pro/domain/entities/license/license_type.dart';

class UserTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get licenseId => textEnum<LicenseType>()();

  TextColumn get name => text().withLength(min: 2, max: 32)();
}
