import 'package:onthi_gplx_pro/core/database/app_database.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/entities/user/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.license,
    required super.name,
    super.age,
    super.avatarPath,
    super.phoneNumber,
    super.createdAt,
    super.updatedAt,
  });

  factory UserModel.fromDrift(UserTableData user) {
    return UserModel(
      id: user.id,
      license: user.licenseId,
      name: user.name,
      age: user.age,
      avatarPath: user.avatarPath,
      phoneNumber: user.phoneNumber,
      createdAt: user.createdAt,
      updatedAt: user.updatedAt,
    );
  }

  UserEntity toEntity() {
    return UserEntity(id: id, license: license, name: name);
  }
}
