import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/entities/user_entity.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/usecases/watch_current_user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final WatchCurrentUserUseCase _watchCurrentUserUseCase;
  AuthBloc(this._watchCurrentUserUseCase) : super(AuthInitial()) {
    on<AuthStarted>((event, emit) async {
      await emit.forEach<UserEntity?>(
        _watchCurrentUserUseCase(),
        onData: (user) {
          if (user == null) return Unauthenticated();
          return Authenticated();
        },
        onError: (err, _) => AuthenticateFail(err.toString()),
      );
    });
  }
}
