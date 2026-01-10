part of 'license_bloc.dart';

sealed class LicenseEvent extends Equatable {
  const LicenseEvent();

  @override
  List<Object> get props => [];
}

final class LoadLicenses extends LicenseEvent {}

final class SelectLicense extends LicenseEvent {}
