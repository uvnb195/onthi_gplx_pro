import 'package:equatable/equatable.dart';

class LicenseEntity extends Equatable {
  final int id;
  final String code;
  final String description;

  const LicenseEntity({
    required this.id,
    required this.code,
    required this.description,
  });

  @override
  List<Object?> get props => [id, code, description];
}
