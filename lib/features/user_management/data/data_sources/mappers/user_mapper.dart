import 'package:onthi_gplx_pro/core/database/dao/index.dart';
import 'package:onthi_gplx_pro/features/user_management/data/data_sources/mappers/license_mapper.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/entities/user_entity.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/value_objects/index.dart';

extension UserMapper on UserWithLicense {
  UserEntity toEntity() {
    return UserEntity(
      id: user.id,
      license: license.toEntity(),
      name: Name.fromDrift(user.name),
      gender: Gender.fromDrift(
        user.gender == 0 ? GenderType.MALE : GenderType.FEMALE,
      ),
      age: Age.fromDrift(user.age),
    );
  }
}
