import 'package:dart_either/dart_either.dart';
import 'package:onthi_gplx_pro/core/error/failure.dart';
import 'package:onthi_gplx_pro/domain/entities/user/user_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> getCurrentUser();

  Future<void> createUser();
}
