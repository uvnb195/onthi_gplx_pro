import 'package:dart_either/dart_either.dart';
import 'package:injectable/injectable.dart';
import 'package:onthi_gplx_pro/core/error/failures.dart';
import 'package:onthi_gplx_pro/core/usecase/usecase.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/repositories/user_repository.dart';

@injectable
class DeleteUserUseCase extends UseCase<void, NoParams> {
  final UserRepository _userRepository;

  DeleteUserUseCase(this._userRepository);

  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return _userRepository.clearUser();
  }
}
