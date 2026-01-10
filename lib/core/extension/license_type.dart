import 'package:onthi_gplx_pro/features/user_management/domain/value_objects/license.dart';

extension LicenseTypeExt on LicenseType {
  String get code {
    switch (this) {
      case LicenseType.a1:
        return 'A1';
      case LicenseType.a:
        return 'A';
      case LicenseType.b1:
        return 'B1';
      case LicenseType.b:
        return 'B';
      case LicenseType.c1:
        return 'C1';
      case LicenseType.c:
        return 'C';
      case LicenseType.d1:
        return 'D1';
      case LicenseType.d2:
        return 'D2';
      case LicenseType.d:
        return 'D';
      case LicenseType.be:
        return 'BE';
      case LicenseType.c1e:
        return 'C1E';
      case LicenseType.ce:
        return 'CE';
      case LicenseType.d1e:
        return 'D1E';
      case LicenseType.d2e:
        return 'D2E';
      case LicenseType.de:
        return 'DE';
    }
  }

  static LicenseType? fromString(String input) {
    switch (input.toLowerCase()) {
      case 'a1':
        return LicenseType.a1;
      case 'a':
        return LicenseType.a;
      case 'b1':
        return LicenseType.b1;
      case 'b':
        return LicenseType.b;
      case 'c1':
        return LicenseType.c1;
      case 'c':
        return LicenseType.c;
      case 'd1':
        return LicenseType.d1;
      case 'd2':
        return LicenseType.d2;
      case 'd':
        return LicenseType.d;
      case 'be':
        return LicenseType.be;
      case 'c1e':
        return LicenseType.c1e;
      case 'ce':
        return LicenseType.ce;
      case 'd1e':
        return LicenseType.d1e;
      case 'd2e':
        return LicenseType.d2e;
      case 'de':
        return LicenseType.de;
      default:
        return null;
    }
  }
}
