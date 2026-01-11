import 'package:drift/drift.dart';
import 'package:onthi_gplx_pro/core/database/app_database.dart';
import 'package:onthi_gplx_pro/core/database/dao/user/user_dao.dart';
import 'package:onthi_gplx_pro/core/extension/gender_type.dart';
import 'package:onthi_gplx_pro/features/user_management/data/models/index.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/entities/index.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/value_objects/index.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.name,
    required super.license,
    required super.gender,
    required super.age,
    super.avatarPath,
    super.phoneNumber,
  });

  factory UserModel.fromDrift(UserWithLicense data) {
    final user = data.user;
    final license = data.license;
    return UserModel(
      id: user.id,
      license: LicenseModel.fromDrift(license),
      name: Name.create(user.name),
      age: Age.create(user.age),
      gender: Gender.create(GenderTypeExt.fromInt(user.gender)!),
      avatarPath: AvatarPath.create(user.avatarPath),
      phoneNumber: PhoneNumber.create(user.phoneNumber),
    );
  }

  UserTableCompanion toDrift() {
    return UserTableCompanion(
      id: Value(id),
      name: Value(name.value),
      licenseId: Value(license.id),
      age: Value(age.value!),
      gender: Value(gender.value.intValue),
      avatarPath: Value(avatarPath?.value),
      phoneNumber: Value(phoneNumber?.value),
    );
  }
}
