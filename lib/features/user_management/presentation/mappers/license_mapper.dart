import 'package:onthi_gplx_pro/features/user_management/domain/value_objects/index.dart';

extension LicenseMapper on LicenseType {
  String get displayName => switch (this) {
    LicenseType.a1 => 'Hạng A1',
    LicenseType.a => 'Hạng A',
    LicenseType.b1 => 'Hạng B1',
    LicenseType.b => 'Hạng B',
    LicenseType.c1 => 'Hạng C1',
    LicenseType.c => 'Hạng C',
    LicenseType.d1 => 'Hạng D1',
    LicenseType.d2 => 'Hạng D2',
    LicenseType.d => 'Hạng D',
    LicenseType.be => 'Hạng BE',
    LicenseType.c1e => 'Hạng C1E',
    LicenseType.ce => 'Hạng CE',
    LicenseType.d1e => 'Hạng D1E',
    LicenseType.d2e => 'Hạng D2E',
    LicenseType.de => 'Hạng DE',
  };
}
