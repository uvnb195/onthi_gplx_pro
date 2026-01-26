import 'package:onthi_gplx_pro/core/database/app_database.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/entities/index.dart';

class LicenseModel extends LicenseEntity {
  const LicenseModel({
    required super.id,
    required super.code,
    required super.description,
  });

  factory LicenseModel.fromDrift(LicenseTableData license) {
    return LicenseModel(
      id: license.id,
      code: license.code.name,
      description: license.description,
    );
  }
}
