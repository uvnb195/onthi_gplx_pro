import 'package:onthi_gplx_pro/core/database/app_database.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/entities/user/user_entity.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/value_objects/age.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/value_objects/avatar_path.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/value_objects/gender.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/value_objects/license_type.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/value_objects/name.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/value_objects/phone_number.dart';

class UserModel {
  final int id;
  final String name;
  final String license;
  final int gender;
  final String? avatarPath;
  final int? age;
  final String? phoneNumber;

  UserModel({
    required this.id,
    required this.name,
    required this.license,
    required this.gender,
    this.age,
    this.avatarPath,
    this.phoneNumber,
  });

  factory UserModel.fromDrift(UserTableData user) {
    return UserModel(
      id: user.id,
      license: user.licenseId.code,
      name: user.name,
      age: user.age,
      gender: user.gender,
      avatarPath: user.avatarPath,
      phoneNumber: user.phoneNumber,
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      name: Name.create(name),
      license: License.create(license),
      gender: Gender.create(gender),
      age: Age.create(age),
      avatarPath: AvatarPath.create(avatarPath),
      phoneNumber: PhoneNumber.create(phoneNumber),
    );
  }
}
