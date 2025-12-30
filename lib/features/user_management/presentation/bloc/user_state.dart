part of 'user_bloc.dart';

enum SubmissionStatus { initial, submitting, success, failure }

class UserFormSubmissionState extends Equatable {
  final String name;
  final String? nameError;
  final String age;
  final String? ageError;
  final String avatarPath;
  final String? avatarPathError;
  final String gender;
  final String? genderError;
  final String license;
  final String? licenseError;
  final String phone;
  final String? phoneError;

  final SubmissionStatus status;
  final String? submitError;

  const UserFormSubmissionState({
    this.name = '',
    this.nameError,
    this.age = '',
    this.ageError,
    this.avatarPath = '',
    this.avatarPathError,
    this.gender = '',
    this.genderError,
    this.license = '',
    this.licenseError,
    this.phone = '',
    this.phoneError,
    this.status = SubmissionStatus.initial,
    this.submitError,
  });

  UserFormSubmissionState copyWith({
    final String? name,
    final String? nameError,
    final String? age,
    final String? ageError,
    final String? avatarPath,
    final String? avatarPathError,
    final String? gender,
    final String? genderError,
    final String? license,
    final String? licenseError,
    final String? phone,
    final String? phoneError,
    final SubmissionStatus? status,
    final String? submitError,
  }) {
    return UserFormSubmissionState(
      name: name ?? this.name,
      nameError: nameError,
      age: age ?? this.age,
      ageError: ageError,
      avatarPath: avatarPath ?? this.avatarPath,
      avatarPathError: avatarPathError,
      gender: gender ?? this.gender,
      genderError: genderError,
      license: license ?? this.license,
      licenseError: licenseError,
      phone: phone ?? this.phone,
      phoneError: phoneError,
      status: status ?? this.status,
      submitError: submitError,
    );
  }

  @override
  List<Object> get props => [
    name,
    age,
    avatarPath,
    gender,
    license,
    phone,
    status,
  ];
}
