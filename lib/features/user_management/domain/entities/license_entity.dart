import 'package:equatable/equatable.dart';
import 'package:onthi_gplx_pro/core/constants/index.dart';

class LicenseEntity extends Equatable {
  final LicenseType value;
  final String description;

  const LicenseEntity({required this.value, required this.description});

  @override
  List<Object?> get props => [value, description];
}
