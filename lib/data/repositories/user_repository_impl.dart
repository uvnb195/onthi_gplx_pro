import 'package:dart_either/src/dart_either.dart';
import 'package:onthi_gplx_pro/core/error/failure.dart';
import 'package:onthi_gplx_pro/data/data_sources/local/dao/user_dao.dart';
import 'package:onthi_gplx_pro/domain/entities/user/user_entity.dart';
import 'package:onthi_gplx_pro/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  UserDao _userDao;

  UserRepositoryImpl(this._userDao);

  @override
  Future<void> createUser() {
    // TODO: implement createUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    try {
      final model = await _userDao.getCurrentUser();
      if (model == null) return Left(UserNotFoundFailure());
      return Right(model.toEntity());
    } catch (e) {
      return Left(DatabaseFailure('Database Error'));
    }
  }
}
