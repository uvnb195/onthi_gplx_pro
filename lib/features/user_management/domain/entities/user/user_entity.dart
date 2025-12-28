import 'package:onthi_gplx_pro/features/user_management/domain/entities/license/license_type.dart';

class UserEntity {
  final int id;
  final String name;
  final LicenseType license;
  final String? avatarPath;
  final int? age;
  final String? phoneNumber;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserEntity({
    required this.id,
    required this.license,
    required this.name,
    this.age,
    this.avatarPath,
    this.phoneNumber,
    this.createdAt,
    this.updatedAt,
  });
}
