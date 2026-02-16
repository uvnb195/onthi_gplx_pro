import 'package:dart_either/dart_either.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:onthi_gplx_pro/core/database/app_database.dart';
import 'package:onthi_gplx_pro/core/error/failures.dart';
import 'package:onthi_gplx_pro/features/user_management/data/data_sources/local/index.dart';
import 'package:onthi_gplx_pro/features/user_management/data/mappers/user_mapper.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/entities/index.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/repositories/index.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final LocalUserDataSource _localUserDataSource;

  UserRepositoryImpl(this._localUserDataSource);

  @override
  Future<Either<Failure, int>> createUser(UserEntity user) async {
    try {
      final companion = UserTableCompanion(
        name: Value(user.name.value),
        age: Value(user.age.value!),
        gender: Value(user.gender),
        avatarPath: Value(user.avatarPath?.value),
        phoneNumber: Value(user.phoneNumber?.value),
        licenseId: Value(user.license.value.id),
        createdAt: Value(DateTime.now()),
        updatedAt: Value(DateTime.now()),
      );

      final userId = await _localUserDataSource.createUser(companion);
      return Right(userId);
    } catch (e) {
      return Left(
        DatabaseFailure('Lỗi khởi tạo người dùng. Vui lòng thử lại.'),
      );
    }
  }

  @override
  Stream<Either<Failure, UserEntity>> watchCurrentUser() {
    return _localUserDataSource
        .currentUserStream()
        .map<Either<Failure, UserEntity>>((result) {
          if (result == null) {
            return Left(CacheFailure('Không tìm thấy User.'));
          } else {
            return Right(result.toEntity());
          }
        })
        .handleError(
          (e) => Left(
            DatabaseFailure(
              'Lỗi khi lấy thông tin người dùng. Vui lòng thử lại sau. ${e.toString()}',
            ),
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
