import 'package:flutter_test/flutter_test.dart';
import 'package:onthi_gplx_pro/core/database/app_database.dart';
import 'package:onthi_gplx_pro/core/database/dao/user/user_dao.dart';
import 'package:onthi_gplx_pro/features/user_management/data/models/user_model.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/value_objects/license.dart';

void main() {
  group("UserModel.fromDrift", () {
    test('Should return a valid UserModel when data is full-fill', () {
      final UserTableData mockUser = UserTableData(
        id: 1,
        licenseId: 0,
        name: 'Quan',
        gender: 0,
        age: 18,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      final LicenseTableData mockLicense = LicenseTableData(
        id: 0,
        code: LicenseType.a1,
        description: "Dung tích dưới 175cc",
      );

      final result = UserModel.fromDrift(
        UserWithLicense(user: mockUser, license: mockLicense),
      );

      expect(result.id, equals(1));
      expect(result.license.id, equals(0));
      expect(result.license.code, 'a1');
    });
  });
}
