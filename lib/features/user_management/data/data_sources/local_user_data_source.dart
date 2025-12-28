import 'package:onthi_gplx_pro/features/user_management/data/models/user_model.dart';

abstract class LocalUserDataSource {
  Future<UserModel?> getCurrentUser();

  Future<void> clearUser();
  Future<void> insertUser();
}
