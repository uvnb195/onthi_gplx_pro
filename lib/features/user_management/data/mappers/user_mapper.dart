import 'package:onthi_gplx_pro/core/database/models/index.dart';
import 'package:onthi_gplx_pro/features/user_management/data/mappers/license_mapper.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/entities/user_entity.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/value_objects/index.dart';

extension UserMapper on UserWithLicense {
  UserEntity toEntity() {
    return UserEntity(
      id: user.id,
      license: license.toEntity(),
      name: Name.fromDrift(user.name),
      gender: user.gender,
      age: Age.fromDrift(user.age),
    );
  }
}
