import 'package:bloc/bloc.dart';
import 'package:dart_either/dart_either.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:onthi_gplx_pro/core/error/failures.dart';
import 'package:onthi_gplx_pro/core/usecase/usecase.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/entities/user_entity.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/usecases/index.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@lazySingleton
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final WatchCurrentUserUseCase _watchCurrentUserUseCase;
  final DeleteUserUseCase _deleteUserUseCase;
  AuthBloc({
    required WatchCurrentUserUseCase watchCurrentUserUseCase,
    required DeleteUserUseCase deleteUserUseCase,
  }) : _watchCurrentUserUseCase = watchCurrentUserUseCase,
       _deleteUserUseCase = deleteUserUseCase,
       super(AuthInitial()) {
    on<AuthStarted>((event, emit) async {
      await emit.forEach<Either<Failure, UserEntity>>(
        _watchCurrentUserUseCase(NoParams()),
        onData: (either) => either.fold(
          ifLeft: (error) => Unauthenticated(),
          ifRight: (success) => Authenticated(success),
        ),
        onError: (err, _) => AuthenticateFail(err.toString()),
      );
    });

    on<AuthLoggedOut>((event, emit) {
      _deleteUserUseCase(NoParams());
      emit(Unauthenticated());
    });
  }
}
