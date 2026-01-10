import 'package:onthi_gplx_pro/core/database/dao/user/user_dao.dart';
import 'package:onthi_gplx_pro/core/extension/gender_type.dart';
import 'package:onthi_gplx_pro/features/user_management/data/models/index.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/value_objects/index.dart';

import '../../domain/entities/index.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.name,
    super.license,
    required super.gender,
    super.age,
    super.avatarPath,
    super.phoneNumber,
  });

  factory UserModel.fromDrift(UserWithLicense data) {
    final user = data.user;
    final license = data.license;
    return UserModel(
      id: user.id,
      license: license == null ? null : LicenseModel.fromDrift(license),
      name: Name.create(user.name),
      age: Age.create(user.age),
      gender: Gender.create(GenderTypeExt.fromInt(user.gender)!),
      avatarPath: AvatarPath.create(user.avatarPath),
      phoneNumber: PhoneNumber.create(user.phoneNumber),
    );
  }
}
