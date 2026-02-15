import 'package:flutter_test/flutter_test.dart';
import 'package:onthi_gplx_pro/core/database/app_database.dart';

import '../../../helpers/db_helper.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase db;

  setUp(() async {
    db = setUpTestDb();
  });

  tearDown(() async {
    await db.close();
  });

  group('Test User Dao', () {
    test('check seed data inserted', () async {
      final result = await db.userDao.getAllLicenses();
      expect(result.length, greaterThan(0));
      expect(result.length, 15);

      print(result);
    });
  });
}
