import 'package:onthi_gplx_pro/features/user_management/domain/entities/user_entity.dart';

abstract class UserRepository {
  Stream<UserEntity?> watchCurrentUser();

  Future<void> createUser();
}
