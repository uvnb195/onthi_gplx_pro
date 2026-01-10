import 'package:onthi_gplx_pro/core/extension/gender_type.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/entities/index.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/repositories/index.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/value_objects/index.dart';

import '../data_sources/local/index.dart';
import '../models/index.dart';

class UserRepositoryImpl implements UserRepository {
  final LocalUserDataSource _localUserDataSource;

  UserRepositoryImpl(this._localUserDataSource);

  @override
  Future<void> createUser() {
    // TODO: implement createUser
    throw UnimplementedError();
  }

  @override
  Stream<UserEntity?> watchCurrentUser() {
    return _localUserDataSource.currentUserStream().map(
      (data) => data == null
          ? null
          : UserEntity(
              id: data.user.id,
              license: data.license == null
                  ? null
                  : LicenseModel.fromDrift(data.license!),
              name: Name.create(data.user.name),
              gender: Gender.create(GenderTypeExt.fromInt(data.user.gender)!),
            ),
    );
  }
}
