part of 'user_bloc.dart';

enum SubmissionStatus { initial, submitting, success, failure }

class UserFormSubmissionState extends Equatable {
  final bool isLoading;
  final String name;
  final String? nameError;
  final String age;
  final String? ageError;
  final String avatarPath;
  final String? avatarPathError;
  final GenderType gender;
  final String? genderError;
  final int? licenseId;
  final LicenseType? license;
  final String? licenseError;
  final String phone;
  final String? phoneError;

  final SubmissionStatus status;
  final String? submitError;

  const UserFormSubmissionState({
    this.isLoading = false,
    this.name = '',
    this.nameError,
    this.age = '',
    this.ageError,
    this.avatarPath = '',
    this.avatarPathError,
    this.gender = GenderType.MALE,
    this.genderError,
    this.licenseId,
    this.license,
    this.licenseError,
    this.phone = '',
    this.phoneError,
    this.status = SubmissionStatus.initial,
    this.submitError,
  });

  UserFormSubmissionState copyWith({
    final bool? isLoading,
    final String? name,
    final String? nameError,
    final String? age,
    final String? ageError,
    final String? avatarPath,
    final String? avatarPathError,
    final GenderType? gender,
    final String? genderError,
    final int? licenseId,
    final LicenseType? license,
    final String? licenseError,
    final String? phone,
    final String? phoneError,
    final SubmissionStatus? status,
    final String? submitError,
  }) {
    return UserFormSubmissionState(
      isLoading: isLoading ?? this.isLoading,
      name: name ?? this.name,
      nameError: nameError,
      age: age ?? this.age,
      ageError: ageError,
      avatarPath: avatarPath ?? this.avatarPath,
      avatarPathError: avatarPathError,
      gender: gender ?? this.gender,
      genderError: genderError,
      licenseId: licenseId ?? this.licenseId,
      license: license ?? this.license,
      licenseError: licenseError,
      phone: phone ?? this.phone,
      phoneError: phoneError,
      status: status ?? this.status,
      submitError: submitError,
    );
  }

  bool get isStep1Valid => nameError == null && name.isNotEmpty;

  bool get isStep2Valid =>
      phoneError == null &&
      ageError == null &&
      genderError == null &&
      age.isNotEmpty;

  bool get isStep3Valid => licenseError == null && license != null;

  @override
  List<Object?> get props => [
    isLoading,
    name,
    nameError,
    age,
    ageError,
    avatarPath,
    avatarPathError,
    gender,
    genderError,
    licenseId,
    license,
    licenseError,
    phone,
    phoneError,
    status,
    submitError,
  ];
}
