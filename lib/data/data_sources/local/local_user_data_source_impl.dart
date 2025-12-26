import 'package:onthi_gplx_pro/data/data_sources/local/dao/user_dao.dart';
import 'package:onthi_gplx_pro/data/data_sources/local/local_user_data_source.dart';
import 'package:onthi_gplx_pro/data/models/user_model.dart';

class LocalUserDataSourceImpl implements LocalUserDataSource {
  final UserDao _userDao;

  const LocalUserDataSourceImpl(this._userDao);

  @override
  Future<void> clearUser() {
    // TODO: implement clearUser
    throw UnimplementedError();
  }

  @override
  Future<UserModel?> getCurrentUser() {
    return _userDao.getCurrentUser();
  }

  @override
  Future<void> insertUser() {
    // TODO: implement insertUser
    throw UnimplementedError();
  }
}
