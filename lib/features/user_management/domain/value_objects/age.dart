import 'package:dart_either/dart_either.dart';
import 'package:onthi_gplx_pro/core/error/exceptions.dart';
import 'package:onthi_gplx_pro/core/error/failures.dart';

class Age {
  final int? age;
  const Age._(this.age);

  factory Age.create(int? input) {
    if (input == null) throw ValidationException('Vui lòng nhập tuổi');

    if (input < 16 || input >= 100) {
      throw ValidationException('Vui lòng nhập đúng tuổi của bạn');
    }

    return Age._(input);
  }

  static Either<Failure, Age> validate(String input) {
    try {
      final inputNum = int.tryParse(input);
      if (inputNum == null) return Left(ValidationFailure('Tuổi không hợp lệ'));

      return Right(Age.create(inputNum));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(e.message));
    }
  }
}
