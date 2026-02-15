import 'package:injectable/injectable.dart';
import 'package:onthi_gplx_pro/core/database/app_database.dart';

@module
abstract class RegisterModule {
  @singleton
  AppDatabase get database => AppDatabase();

  // shared preferences in future
}
