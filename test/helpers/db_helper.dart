import 'package:drift/native.dart';
import 'package:onthi_gplx_pro/core/database/app_database.dart';

AppDatabase setupMockDb() {
  return AppDatabase(NativeDatabase.memory());
}
