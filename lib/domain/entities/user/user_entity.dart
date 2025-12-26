import 'package:onthi_gplx_pro/domain/entities/license/license_type.dart';

class UserEntity {
  final int id;
  final String? name;
  final LicenseType license;
  UserEntity({required this.id, required this.license, this.name});
}
