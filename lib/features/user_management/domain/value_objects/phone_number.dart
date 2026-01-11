import 'package:dart_either/dart_either.dart';
import 'package:onthi_gplx_pro/core/error/exceptions.dart';
import 'package:onthi_gplx_pro/core/error/failures.dart';

class PhoneNumber {
  final String? value;

  const PhoneNumber._(this.value);

  factory PhoneNumber.create(String? phone) {
    final message = 'Số điện thoại không hợp lệ';

    if (phone == null || phone.isEmpty) return PhoneNumber._(null);
    if (phone.length != 10) throw ValidationException(message);
    if (!phone.startsWith('0')) throw ValidationException(message);

    return PhoneNumber._(phone);
  }

  static Either<ValidationFailure, PhoneNumber> validate(String input) {
    try {
      return Right(PhoneNumber.create(input));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(e.message));
    }
  }
}
