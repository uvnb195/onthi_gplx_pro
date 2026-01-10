import 'package:dart_either/dart_either.dart';
import 'package:onthi_gplx_pro/core/error/exceptions.dart';
import 'package:onthi_gplx_pro/core/error/failures.dart';

enum LicenseType { a1, a, b1, b, c1, c, d1, d2, d, be, c1e, ce, d1e, d2e, de }

class License {
  final LicenseType license;

  const License._(this.license);

  factory License.create(LicenseType input) {
    return License._(input);
  }

  static Either<Failure, License> validate(LicenseType? input) {
    if (input == null) {
      return Left(ValidationFailure('Vui lòng chọn Hạng GPLX'));
    }

    try {
      return Right(License.create(input));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(e.message));
    }
  }
}
