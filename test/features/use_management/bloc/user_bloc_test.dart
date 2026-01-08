import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:onthi_gplx_pro/features/user_management/presentation/bloc/user_bloc.dart';

void main() {
  late UserBloc userBloc;
  setUp(() => userBloc = UserBloc());

  group('Name State Test', () {
    tearDown(() {
      userBloc.close();
    });

    test('initial state should be UserFormSubmissionState', () {
      expect(userBloc.state, UserFormSubmissionState());
    });

    blocTest<UserBloc, UserFormSubmissionState>(
      'should emit nameError while name is empty',
      build: () => userBloc,
      act: (userBloc) => userBloc.add(NameChanged("")),
      expect: () => [
        UserFormSubmissionState(
          name: "",
          nameError: "Vui lòng không để trống Tên",
        ),
      ],
    );
    blocTest<UserBloc, UserFormSubmissionState>(
      'should emit nameError while name is under less than characters',
      build: () => userBloc,
      act: (userBloc) => userBloc.add(NameChanged("z")),
      expect: () => [
        UserFormSubmissionState(name: "z", nameError: "Tên phải từ 02 ký tự"),
      ],
    );
    blocTest<UserBloc, UserFormSubmissionState>(
      'should emit [nameError:null] when name is valid',
      build: () => userBloc,
      act: (userBloc) => userBloc.add(NameChanged("Quan")),
      expect: () => [UserFormSubmissionState(name: "Quan", nameError: null)],
    );
  });
}
