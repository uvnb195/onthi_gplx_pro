import 'package:dart_either/src/dart_either.dart';
import 'package:onthi_gplx_pro/core/error/failures.dart';
import 'package:onthi_gplx_pro/core/usecase/usecase.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/entities/user/user_entity.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/repositories/user_repository.dart';

class GetCurrentUserUseCase extends UseCase<UserEntity, NoParams> {
  final UserRepository _userRepository;

  GetCurrentUserUseCase(this._userRepository);

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) {
    return _userRepository.getCurrentUser();
  }
}
