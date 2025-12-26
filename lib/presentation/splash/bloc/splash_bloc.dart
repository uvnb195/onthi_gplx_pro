import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:onthi_gplx_pro/core/error/failure.dart';
import 'package:onthi_gplx_pro/core/usecase/usecase.dart';
import 'package:onthi_gplx_pro/domain/entities/user/user_entity.dart';
import 'package:onthi_gplx_pro/domain/usercases/get_current_user.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final GetCurrentUserUseCase _getCurrentUserUseCase;

  SplashBloc(this._getCurrentUserUseCase) : super(SplashInitial()) {
    on<SplashStarted>(_onSplashStarted);
  }

  Future<void> _onSplashStarted(
    SplashEvent event,
    Emitter<SplashState> emit,
  ) async {
    emit(SplashLoading());
    final result = await _getCurrentUserUseCase(NoParams());

    result.fold(
      ifLeft: (failure) {
        if (failure is UserNotFoundFailure) {
          emit(SplashToOnboarding());
        } else {
          emit(SplashError(failure.message));
        }
      },
      ifRight: (user) {
        emit(SplashToHome(user));
      },
    );
  }
}
