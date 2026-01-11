import 'package:dart_either/dart_either.dart';
import 'package:onthi_gplx_pro/core/error/failures.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/entities/user_entity.dart';

abstract class UserRepository {
  Stream<UserEntity?> watchCurrentUser();

  Future<Either<Failure, int>> createUser(UserEntity user);

  Future<Either<Failure, void>> clearUser();
}
