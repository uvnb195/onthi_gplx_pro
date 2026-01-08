import 'package:onthi_gplx_pro/core/database/app_database.dart';
import 'package:onthi_gplx_pro/core/extension/gender_type.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/entities/user/user_entity.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/value_objects/age.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/value_objects/avatar_path.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/value_objects/gender.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/value_objects/license_type.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/value_objects/name.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/value_objects/phone_number.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.name,
    required super.license,
    required super.gender,
    super.age,
    super.avatarPath,
    super.phoneNumber,
  });

  factory UserModel.fromDrift(UserTableData user) {
    return UserModel(
      id: user.id,
      license: License.create(user.licenseId.code),
      name: Name.create(user.name),
      age: Age.create(user.age),
      gender: Gender.create(GenderTypeExt.fromInt(user.gender)!),
      avatarPath: AvatarPath.create(user.avatarPath),
      phoneNumber: PhoneNumber.create(user.phoneNumber),
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      name: name,
      license: license,
      gender: gender,
      age: age,
      avatarPath: avatarPath,
      phoneNumber: phoneNumber,
    );
  }
}
