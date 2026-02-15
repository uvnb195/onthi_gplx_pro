import 'package:dart_either/dart_either.dart';
import 'package:injectable/injectable.dart';
import 'package:onthi_gplx_pro/core/error/failures.dart';
import 'package:onthi_gplx_pro/core/usecase/usecase.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/entities/index.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/repositories/index.dart';

@lazySingleton
class WatchCurrentUserUseCase extends StreamUseCase<UserEntity, NoParams> {
  final UserRepository _repository;

  WatchCurrentUserUseCase(this._repository);

  @override
  Stream<Either<Failure, UserEntity>> call(NoParams params) {
    return _repository.watchCurrentUser();
  }
}
