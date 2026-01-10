import 'package:onthi_gplx_pro/features/user_management/domain/entities/index.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/value_objects/index.dart';

class UserEntity {
  final int id;
  final Name name;
  final LicenseEntity? license;
  final Gender gender;
  final AvatarPath? avatarPath;
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
