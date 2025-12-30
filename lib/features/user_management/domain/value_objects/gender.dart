import 'package:dart_either/dart_either.dart';
import 'package:onthi_gplx_pro/core/error/exceptions.dart';
import 'package:onthi_gplx_pro/core/error/failures.dart';

class Gender {
  final int gender; //ONLY 0:MALE AND 1:FEMALE
  const Gender._(this.gender);

  factory Gender.create(int gender) {
    if (gender != 0 || gender != 1) {
      throw ValidationException('Vui lòng chọn đúng giới tính');
    }

    return Gender._(gender);
  }

  static Either<ValidationFailure, Gender> validate(String input) {
    try {
      final genderInt = int.tryParse(input);
      if (genderInt == null) {
        return Left(ValidationFailure("Giới tính không hợp lệ"));
      }

      return Right(Gender.create(genderInt));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(e.message));
    }
  }
}
