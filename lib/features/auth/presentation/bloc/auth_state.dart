part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthChanged extends AuthState {}

final class Authenticated extends AuthState {
  final UserEntity user;
  const Authenticated(this.user);
}

final class Unauthenticated extends AuthState {}

final class AuthenticateFail extends AuthState {
  final String message;
  const AuthenticateFail(this.message);
}
