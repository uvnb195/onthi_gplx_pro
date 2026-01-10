part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

final class Loading extends UserEvent {
  final bool state;
  const Loading(this.state);
}

final class NameChanged extends UserEvent {
  final String name;
  const NameChanged(this.name);
}

final class AvatarChanged extends UserEvent {
  final String avatarPath;
  const AvatarChanged(this.avatarPath);
}

final class AgeChanged extends UserEvent {
  final String age;
  const AgeChanged(this.age);
}

final class GenderChanged extends UserEvent {
  final GenderType? gender;
  const GenderChanged(this.gender);
}

final class LicenseChanged extends UserEvent {
  final LicenseEntity license;
  const LicenseChanged(this.license);
}

final class PhoneChanged extends UserEvent {
  final String phone;
  const PhoneChanged(this.phone);
}

final class UserChanged extends UserEvent {
  final int? id; // null for create, id for update

  const UserChanged(this.id);
}
