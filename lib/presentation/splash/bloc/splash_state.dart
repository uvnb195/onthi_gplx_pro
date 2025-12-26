part of 'splash_bloc.dart';

sealed class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

final class SplashInitial extends SplashState {}

final class SplashLoading extends SplashState {}

final class SplashToOnboarding extends SplashState {}

final class SplashToHome extends SplashState {
  final UserEntity user;
  const SplashToHome(this.user);

  @override
  List<Object> get props => [user];
}

final class SplashError extends SplashState {
  final String message;
  const SplashError(this.message);

  @override
  List<Object> get props => [message];
}
