import 'package:drift/drift.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/value_objects/license.dart';

class LicenseTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get code => textEnum<LicenseType>().withLength(min: 1, max: 3)();
  TextColumn get description => text()();
}
