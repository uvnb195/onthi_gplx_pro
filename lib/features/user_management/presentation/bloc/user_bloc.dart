import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/value_objects/name.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserFormSubmissionState> {
  UserBloc() : super(const UserFormSubmissionState()) {
    on<NameChanged>(_onNameChanged);
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
}
