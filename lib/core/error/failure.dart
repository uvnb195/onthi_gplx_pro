abstract class Failure {
  final String message;
  const Failure(this.message);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message);
}

class UserNotFoundFailure extends Failure {
  const UserNotFoundFailure() : super('User not found');
}
