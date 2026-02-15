import 'package:onthi_gplx_pro/core/database/app_database.dart';

class UserWithLicense {
  final UserTableData user;
  final LicenseTableData license;

  const UserWithLicense({required this.user, required this.license});
}
