import 'package:onthi_gplx_pro/features/user_management/domain/value_objects/age.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/value_objects/avatar_path.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/value_objects/gender.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/value_objects/license_type.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/value_objects/name.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/value_objects/phone_number.dart';

class UserEntity {
  final int id;
  final Name name; //
  final License license;
  final Gender gender;
  final AvatarPath? avatarPath; //
  final Age? age;
  final PhoneNumber? phoneNumber;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserEntity({
    required this.id,
    required this.license,
    required this.name,
    required this.gender,
    this.age,
    this.avatarPath,
    this.phoneNumber,
    this.createdAt,
    this.updatedAt,
  });
}
