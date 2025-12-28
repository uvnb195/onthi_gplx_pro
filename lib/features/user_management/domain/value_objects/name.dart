import 'package:dart_either/dart_either.dart';
import 'package:onthi_gplx_pro/core/error/exceptions.dart';
import 'package:onthi_gplx_pro/core/error/failures.dart';

class Name {
  final String value;

  const Name._(this.value);

  factory Name.create(String input) {
    final trimmed = input.trim();

    if (trimmed.isEmpty) {
      throw ValidationException('Vui lòng không để trống Tên');
    }

    if (trimmed.length < 2) {
      throw ValidationException('Tên phải từ 02 ký tự');
    }

    if (trimmed.length > 50) {
      throw ValidationException('Tên quá dài, không được vượt quá 50 ký tự');
    }

    return Name._(trimmed);
  }

  static Either<Failure, Name> validate(String input) {
    try {
      return Right(Name.create(input));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(e.message));
    }
  }
}
