import 'package:flutter_test/flutter_test.dart';
import 'package:onthi_gplx_pro/core/database/app_database.dart';
import 'package:onthi_gplx_pro/core/database/dao/index.dart';

import '../../../helpers/db_helper.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase db;
  late QuestionCategoryDao questionCategoryDao;

  setUp(() async {
    db = setUpTestDb();
    questionCategoryDao = db.questionCategoryDao;
  });

  tearDown(() async {
    await db.close();
  });

  group('Test Question Category Dao', () {
    test('check seed data inserted', () async {
      final result = await questionCategoryDao.getCategories();

      expect(result.length, greaterThan(0));
      expect(result.length, 6);
      expect(
        result.any((element) => element.label == 'Hệ thống Biển báo'),
        isTrue,
      );
    });
  });
}
