part of 'license_bloc.dart';

sealed class LicenseEvent extends Equatable {
  const LicenseEvent();

  @override
  List<Object> get props => [];
}

final class LoadLicenses extends LicenseEvent {}

final class SelectLicense extends LicenseEvent {
  final LicenseEntity selected;
  const SelectLicense(this.selected);

  @override
  List<Object> get props => [selected];
}
