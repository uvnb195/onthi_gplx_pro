import 'package:dart_either/dart_either.dart';
import 'package:onthi_gplx_pro/core/error/failures.dart';
import 'package:onthi_gplx_pro/core/usecase/usecase.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/entities/user_entity.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/repositories/user_repository.dart';

class CreateUserUseCase extends UseCase<int, UserEntity> {
  final UserRepository _repository;

  CreateUserUseCase(this._repository);

  @override
  Future<Either<Failure, int>> call(UserEntity params) {
    return _repository.createUser(params);
  }
}
