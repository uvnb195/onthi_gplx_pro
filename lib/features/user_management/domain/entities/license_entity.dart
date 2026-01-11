import 'package:equatable/equatable.dart';

class LicenseEntity extends Equatable {
  final int id;
  final String code;
  final String description;
  final DateTime updatedAt;

  const LicenseEntity({
    required this.id,
    required this.code,
    required this.description,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [id, code, description];
}
