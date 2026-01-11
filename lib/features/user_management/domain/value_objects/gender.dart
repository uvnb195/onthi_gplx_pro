import 'package:dart_either/dart_either.dart';
import 'package:onthi_gplx_pro/core/error/exceptions.dart';
import 'package:onthi_gplx_pro/core/error/failures.dart';

enum GenderType { MALE, FEMALE }

class Gender {
  final GenderType value;
  const Gender._(this.value);

  factory Gender.create(GenderType gender) {
    return Gender._(gender);
  }

  static Either<ValidationFailure, Gender> validate(GenderType? input) {
    try {
      if (input == null) {
        return Left(ValidationFailure('Vui lòng chọn giới tính'));
      }
      return Right(Gender.create(input));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(e.message));
    }
  }
}
