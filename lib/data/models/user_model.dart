import 'package:onthi_gplx_pro/data/data_sources/local/app_database.dart';
import 'package:onthi_gplx_pro/domain/entities/user/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({required super.id, required super.license, super.name});

  factory UserModel.fromDrift(UserTableData user) {
    return UserModel(id: user.id, license: user.licenseId);
  }

  UserEntity toEntity() {
    return UserEntity(id: id, license: license, name: name);
  }
}
