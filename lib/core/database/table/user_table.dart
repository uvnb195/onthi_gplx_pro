import 'package:drift/drift.dart';
import 'package:onthi_gplx_pro/core/constants/index.dart';
import 'package:onthi_gplx_pro/core/database/table/license_table.dart';

class UserTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get licenseId => integer().references(LicenseTable, #id)();
  TextColumn get name => text().withLength(min: 2, max: 50)();
  IntColumn get age => integer()();
  IntColumn get gender =>
      intEnum<GenderType>().withDefault(const Constant(0))();

  // optional fields
  TextColumn get avatarPath => text().nullable()();
  TextColumn get phoneNumber => text().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
