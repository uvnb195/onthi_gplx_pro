import 'package:dart_either/dart_either.dart';
import 'package:drift/drift.dart';
import 'package:onthi_gplx_pro/core/database/app_database.dart';
import 'package:onthi_gplx_pro/core/error/failures.dart';
import 'package:onthi_gplx_pro/core/extension/gender_type.dart';
import 'package:onthi_gplx_pro/features/user_management/data/data_sources/local/index.dart';
import 'package:onthi_gplx_pro/features/user_management/data/models/index.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/entities/index.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/repositories/index.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/value_objects/index.dart';

class UserRepositoryImpl implements UserRepository {
  final LocalUserDataSource _localUserDataSource;

  UserRepositoryImpl(this._localUserDataSource);

  @override
  Future<Either<Failure, int>> createUser(UserEntity user) async {
    try {
      final companion = UserTableCompanion(
        name: Value(user.name.value),
        age: Value(user.age.value!),
        gender: Value(user.gender.value.intValue),
        avatarPath: Value(user.avatarPath?.value),
        phoneNumber: Value(user.phoneNumber?.value),
        licenseId: Value(user.license.id),
      );

      final userId = await _localUserDataSource.createUser(companion);
      return Right(userId);
    } catch (e) {
      return Left(DatabaseFailure('Lỗi khởi tạo người dùng. Vui lòng thử lại'));
    }
  }

  @override
  Stream<UserEntity?> watchCurrentUser() {
    return _localUserDataSource.currentUserStream().map(
      (data) => data == null
          ? null
          : UserEntity(
              id: data.user.id,
              license: LicenseModel.fromDrift(data.license),
              name: Name.create(data.user.name),
              gender: Gender.create(GenderTypeExt.fromInt(data.user.gender)!),
              age: Age.create(data.user.age),
              avatarPath: AvatarPath.create(data.user.avatarPath),
              phoneNumber: PhoneNumber.create(data.user.phoneNumber),
            ),
    );
  }

  @override
  Future<Either<Failure, void>> clearUser() async {
    try {
      await _localUserDataSource.clearUser();
      return const Right(null);
    } catch (e) {
      return Left(
        DatabaseFailure('Lỗi không xác định. Vui lòng khởi động lại ứng dụng'),
      );
    }
  }
}
