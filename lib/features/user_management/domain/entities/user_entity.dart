import 'package:onthi_gplx_pro/core/constants/index.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/entities/index.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/value_objects/index.dart';

class UserEntity {
  final int id;
  final Name name;
  final LicenseEntity license;
  final GenderType gender;
  final Age age;
  final AvatarPath? avatarPath;
  final PhoneNumber? phoneNumber;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserEntity({
    required this.id,
    required this.license,
    required this.name,
    required this.gender,
    required this.age,
    this.avatarPath,
    this.phoneNumber,
    this.createdAt,
    this.updatedAt,
  });
}
