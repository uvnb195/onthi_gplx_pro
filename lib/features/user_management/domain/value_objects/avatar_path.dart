import 'package:dart_either/dart_either.dart';
import 'package:onthi_gplx_pro/core/error/exceptions.dart';
import 'package:onthi_gplx_pro/core/error/failures.dart';

class AvatarPath {
  final String? path;

  const AvatarPath._(this.path);

  factory AvatarPath.create(String? filePath) {
    if (filePath == null || filePath.isEmpty) return AvatarPath._(null);

    final validExtensions = ['.jpg', '.jpeg', '.png', '.webp'];
    final isValidImage = validExtensions.any(
      (ext) => filePath.toLowerCase().endsWith(ext),
    );
    if (!isValidImage) {
      throw ValidationException(
        'Vui lòng chọn ảnh đúng định dạng (${validExtensions.join(', ')})',
      );
    }

    return AvatarPath._(filePath);
  }

  static Either<ValidationFailure, AvatarPath> validate(String input) {
    try {
      return Right(AvatarPath.create(input));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(e.message));
    }
  }
}
