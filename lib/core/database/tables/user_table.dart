import 'package:drift/drift.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/value_objects/license_type.dart';

class UserTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get licenseId => textEnum<LicenseType>()();
  TextColumn get name => text().withLength(min: 2, max: 50)();
  // optional fields
  TextColumn get avatarPath => text().nullable()();
  Column<int> get age => integer().nullable()();
  TextColumn get phoneNumber => text().nullable()();
  IntColumn get gender => integer()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
