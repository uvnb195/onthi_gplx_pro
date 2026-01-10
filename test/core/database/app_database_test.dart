import 'package:flutter_test/flutter_test.dart';
import 'package:onthi_gplx_pro/core/database/app_database.dart';
import 'package:onthi_gplx_pro/core/database/dao/license/license_dao.dart';
import 'package:onthi_gplx_pro/core/database/dao/user/user_dao.dart';

import '../../helpers/db_helper.dart';

void main() {
  group('LicenseDao testing', () {
    late AppDatabase mockDb;
    late UserDao mockUserDao;
    late LicenseDao mockLicenseDao;

    setUp(() async {
      mockDb = setupMockDb();
      mockUserDao = mockDb.userDao;
      mockLicenseDao = mockDb.licenseDao;
    });

    tearDown(() async {
      await mockDb.close();
    });
    test(
      'should return license.length > 0 because seed data was loading in migration onCreate',
      () async {
        final licenses = await mockLicenseDao.getLicenseList();

        expect(licenses.length, greaterThan(0));
      },
    );

    test('should return license when get by id', () async {
      final licenses = await mockLicenseDao.getLicenseList();
      final int targetId = 1;
      final targetLicense = licenses[targetId - 1];
      final license = await mockLicenseDao.getLicenseById(targetId);

      expect(license!.code, targetLicense.code);
    });
  });

  // group('UserDao testing', () {
  //   late AppDatabase mockDb;
  //   late UserDao mockUserDao;
  //   late LicenseDao mockLicenseDao;

  //   setUp(() async {
  //     mockDb = setupMockDb();
  //     mockUserDao = mockDb.userDao;
  //     mockLicenseDao = mockDb.licenseDao;
  //   });

  //   tearDown(() async {
  //     await mockDb.close();
  //   });

  //   test('should return null when user is not created', () async {
  //     final user = await mockUserDao.getCurrentUser();
  //     expect(user, isNull);
  //   });

  //   test('should return userId when create user success', () async {
  //     final licenses = await mockLicenseDao.getLicenseList();
  //     final targetLicense = licenses.first;
  //     final userId = await mockUserDao.createUser(
  //       UserTableCompanion.insert(
  //         licenseId: targetLicense.id,
  //         name: 'Quan',
  //         age: 18,
  //         gender: 0,
  //       ),
  //     );

  //     final currentUser = await mockUserDao.getCurrentUser();

  //     expect(userId, 1);
  //     expect(currentUser!.user.name, 'Quan');
  //     expect(currentUser.license!.id, targetLicense.id);
  //   });

  //   test(
  //     'result should contain license info when user creation is successful',
  //     () async {
  //       final licenses = await mockLicenseDao.getLicenseList();
  //       final targetLicense = licenses[1];
  //       await mockUserDao.createUser(
  //         UserTableCompanion.insert(
  //           licenseId: targetLicense.id,
  //           name: 'Quan2',
  //           age: 18,
  //           gender: 0,
  //         ),
  //       );

  //       final currentUser = await mockUserDao.getCurrentUser();
  //       expect(currentUser!.user.name, 'Quan2');
  //       expect(currentUser.license!.code, targetLicense.code);
  //     },
  //   );

  //   test(
  //     'SINGLETON USER - should return same id with different name if create second user',
  //     () async {
  //       final licenses = await mockLicenseDao.getLicenseList();
  //       final targetLicense1 = licenses.first;
  //       final targetLicense2 = licenses[1];
  //       final user1 = await mockUserDao.createUser(
  //         UserTableCompanion.insert(
  //           licenseId: targetLicense2.id,
  //           name: 'Quan2',
  //           age: 18,
  //           gender: 0,
  //         ),
  //       );

  //       final user2 = await mockUserDao.createUser(
  //         UserTableCompanion.insert(
  //           licenseId: targetLicense1.id,
  //           name: 'Dao Huu Q',
  //           age: 18,
  //           gender: 0,
  //         ),
  //       );

  //       final currentUser = await mockUserDao.getCurrentUser();

  //       expect(currentUser!.user.id, 1);
  //       expect(currentUser.user.name, 'Dao Huu Q');
  //       expect(currentUser.license!.code, targetLicense1.code);
  //     },
  //   );
  // });
}
