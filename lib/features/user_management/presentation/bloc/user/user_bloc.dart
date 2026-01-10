import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:onthi_gplx_pro/core/extension/index.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/entities/index.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/value_objects/index.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserFormSubmissionState> {
  UserBloc()
    : super(
        const UserFormSubmissionState(
          nameError: '',
          ageError: '',
          licenseError: '',
        ),
      ) {
    on<NameChanged>(_onNameChanged);
    on<AgeChanged>(_onAgeChanged);
    on<GenderChanged>(_onGenderChanged);
    on<PhoneChanged>(_onPhoneChanged);
    on<LicenseChanged>(_onLicenseChanged);

    on<Loading>(_onLoading);
  }

  void _onNameChanged(
    NameChanged event,
    Emitter<UserFormSubmissionState> emit,
  ) {
    final result = Name.validate(event.name);

    result.fold(
      ifLeft: (failure) {
        emit(state.copyWith(name: event.name, nameError: failure.message));
      },
      ifRight: (value) {
        emit(state.copyWith(name: event.name, nameError: null));
      },
    );
  }

  void _onAgeChanged(AgeChanged event, Emitter<UserFormSubmissionState> emit) {
    final result = Age.validate(event.age);

    result.fold(
      ifLeft: (failure) {
        emit(state.copyWith(age: event.age, ageError: failure.message));
      },
      ifRight: (value) {
        emit(state.copyWith(age: event.age, ageError: null));
      },
    );
  }

  void _onGenderChanged(
    GenderChanged event,
    Emitter<UserFormSubmissionState> emit,
  ) {
    final result = Gender.validate(event.gender);

    result.fold(
      ifLeft: (failure) {
        emit(
          state.copyWith(gender: event.gender, genderError: failure.message),
        );
      },
      ifRight: (value) {
        emit(state.copyWith(gender: event.gender, genderError: null));
      },
    );
  }

  void _onPhoneChanged(
    PhoneChanged event,
    Emitter<UserFormSubmissionState> emit,
  ) {
    final result = PhoneNumber.validate(event.phone);

    result.fold(
      ifLeft: (failure) {
        emit(state.copyWith(phone: event.phone, phoneError: failure.message));
      },
      ifRight: (value) {
        emit(state.copyWith(phone: event.phone, phoneError: null));
      },
    );
  }

  void _onLicenseChanged(
    LicenseChanged event,
    Emitter<UserFormSubmissionState> emit,
  ) {
    final licenseType = LicenseTypeExt.fromString(event.license.code);
    final result = License.validate(licenseType);

    result.fold(
      ifLeft: (failure) {
        emit(
          state.copyWith(
            license: licenseType,
            licenseId: event.license.id,
            licenseError: failure.message,
          ),
        );
      },
      ifRight: (value) {
        emit(
          state.copyWith(
            license: licenseType,
            licenseId: event.license.id,
            licenseError: null,
          ),
        );
      },
    );
  }

  void _onLoading(Loading event, Emitter<UserFormSubmissionState> emit) {
    emit(state.copyWith(isLoading: event.state));
  }
}
