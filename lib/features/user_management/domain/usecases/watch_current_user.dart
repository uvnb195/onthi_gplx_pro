import 'package:onthi_gplx_pro/features/user_management/domain/entities/index.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/repositories/index.dart';

class WatchCurrentUserUseCase {
  final UserRepository _repository;

  WatchCurrentUserUseCase(this._repository);

  Stream<UserEntity?> call() {
    return _repository.watchCurrentUser();
  }
}
