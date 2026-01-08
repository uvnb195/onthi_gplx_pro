import 'package:onthi_gplx_pro/features/user_management/domain/value_objects/gender.dart';

extension GenderTypeExt on GenderType {
  String get displayName {
    switch (this) {
      case GenderType.MALE:
        return 'Nam';
      case GenderType.FEMALE:
        return 'Nữ';
    }
  }

  static GenderType? fromString(String? input) {
    switch (input) {
      case 'Nam':
        return .MALE;
      case 'Nữ':
        return .FEMALE;
      default:
        return null;
    }
  }

  static GenderType? fromInt(int? input) {
    switch (input) {
      case 0:
        return .MALE;
      case 1:
        return .FEMALE;
      default:
        return null;
    }
  }
}
