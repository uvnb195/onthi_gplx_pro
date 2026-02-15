import 'package:onthi_gplx_pro/core/database/app_database.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/entities/index.dart';

extension LicenseMapper on LicenseTableData {
  LicenseEntity toEntity() {
    return LicenseEntity(value: code, description: description);
  }
}
