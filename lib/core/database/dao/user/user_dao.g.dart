// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dao.dart';

// ignore_for_file: type=lint
mixin _$UserDaoMixin on DatabaseAccessor<AppDatabase> {
  $LicenseTableTable get licenseTable => attachedDatabase.licenseTable;
  $UserTableTable get userTable => attachedDatabase.userTable;
  UserDaoManager get managers => UserDaoManager(this);
}

class UserDaoManager {
  final _$UserDaoMixin _db;
  UserDaoManager(this._db);
  $$LicenseTableTableTableManager get licenseTable =>
      $$LicenseTableTableTableManager(_db.attachedDatabase, _db.licenseTable);
  $$UserTableTableTableManager get userTable =>
      $$UserTableTableTableManager(_db.attachedDatabase, _db.userTable);
}
