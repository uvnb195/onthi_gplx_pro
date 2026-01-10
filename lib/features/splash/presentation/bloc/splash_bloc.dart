// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:onthi_gplx_pro/core/error/failures.dart';
// import 'package:onthi_gplx_pro/core/usecase/usecase.dart';
// import 'package:onthi_gplx_pro/features/user_management/domain/entities/user_entity.dart';
// import 'package:onthi_gplx_pro/features/user_management/domain/usecases/watch_current_user.dart';

// part 'splash_event.dart';
// part 'splash_state.dart';

// class SplashBloc extends Bloc<SplashEvent, SplashState> {
//   final WatchCurrentUserUseCase _watchCurrentUserUseCase;

//   SplashBloc(this._watchCurrentUserUseCase) : super(SplashInitial()) {
//     on<SplashStarted>(_onSplashStarted);
//   }

//   Future<void> _onSplashStarted(
//     SplashEvent event,
//     Emitter<SplashState> emit,
//   ) async {
//     print('Starting...');
//     emit(SplashLoading());
//     final result = await _watchCurrentUserUseCase();

//     result.fold(
//       ifLeft: (failure) {
//         if (failure is CacheFailure) {
//           emit(SplashToOnboarding());
//         } else {
//           emit(SplashError(failure.message));
//         }
//       },
//       ifRight: (user) {
//         emit(SplashToHome(user));
//       },
//     );
//   }
// }
