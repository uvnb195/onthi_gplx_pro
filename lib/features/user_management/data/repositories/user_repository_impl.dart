import 'package:dart_either/src/dart_either.dart';
import 'package:onthi_gplx_pro/core/error/exceptions.dart';
import 'package:onthi_gplx_pro/core/error/failures.dart';
import 'package:onthi_gplx_pro/features/user_management/data/data_sources/local_user_data_source.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/entities/user/user_entity.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final LocalUserDataSource _localUserDataSource;

  UserRepositoryImpl(this._localUserDataSource);

  @override
  Future<void> createUser() {
    // TODO: implement createUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    try {
      final model = await _localUserDataSource.getCurrentUser();
      if (model == null) return const Left(CacheFailure('Không tìm thấy User'));
      return Right(model.toEntity());
    } on CacheException {
      return const Left(CacheFailure('Lỗi khi lấy thông tin User'));
    }
  }
}
