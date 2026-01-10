part of 'license_bloc.dart';

sealed class LicenseState extends Equatable {
  const LicenseState();

  @override
  List<Object?> get props => [];
}

final class LicenseInitial extends LicenseState {}

final class LicenseLoading extends LicenseState {}

final class LicenseLoaded extends LicenseState {
  final List<LicenseEntity> licenses;
  final LicenseEntity? selectedLicense;
  const LicenseLoaded({required this.licenses, this.selectedLicense});

  @override
  List<Object?> get props => [licenses, selectedLicense];
}

final class LicenseLoadFail extends LicenseState {
  final String message;
  const LicenseLoadFail(this.message);

  @override
  List<Object> get props => [message];
}
