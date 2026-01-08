import 'package:drift/drift.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/value_objects/license_type.dart';

class UserTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get licenseId => textEnum<LicenseType>()();
  TextColumn get name => text().withLength(min: 2, max: 50)();
  Column<int> get age => integer().nullable()();
  IntColumn get gender => integer()();

  // optional fields
  TextColumn get avatarPath => text().nullable()();
  TextColumn get phoneNumber => text().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
