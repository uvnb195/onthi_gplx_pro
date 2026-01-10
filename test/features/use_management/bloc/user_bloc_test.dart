import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/entities/license_entity.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/usecases/get_licenses.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/value_objects/license.dart';
import 'package:onthi_gplx_pro/features/user_management/presentation/bloc/bloc/license_bloc.dart';
import 'package:onthi_gplx_pro/features/user_management/presentation/bloc/user/user_bloc.dart';

// Mock UseCase
class MockGetLicensesUseCase extends Mock implements GetLicensesUseCase {}

class MockLicenseBloc extends MockBloc<LicenseEvent, LicenseState>
    implements LicenseBloc {}

void main() {
  late UserBloc userBloc;
  late MockLicenseBloc mockLicenseBloc;
  setUp(() {
    mockLicenseBloc = MockLicenseBloc();
    userBloc = UserBloc(licenseBloc: mockLicenseBloc);
  });

  tearDown(() {
    userBloc.close();
    mockLicenseBloc.close();
  });

  group('Name State Test', () {
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

void main2() {
  late MockLicenseBloc mockLicenseBloc;
  late StreamController<LicenseState> licenseStreamController;

  final tLicenses = [
    LicenseEntity(
      id: 1,
      code: 'a1',
      description:
          'Mô tô hai bánh có dung tích xi lanh từ 50cm3 đến dưới 175cm3',
      updatedAt: DateTime.now(),
    ),
    LicenseEntity(
      id: 2,
      code: 'a2',
      description: 'Mô tô hai bánh có dung tích xi lanh từ 175cm3 trở lên',
      updatedAt: DateTime.now(),
    ),
    LicenseEntity(
      id: 3,
      code: 'b1',
      description:
          'Ô tô chở người đến 9 chỗ ngồi; xe tải dưới 3.500kg (Số tự động)',
      updatedAt: DateTime.now(),
    ),
    LicenseEntity(
      id: 4,
      code: 'b2',
      description:
          'Ô tô chở người đến 9 chỗ ngồi; xe tải dưới 3.500kg (Số sàn & Tự động)',
      updatedAt: DateTime.now(),
    ),
  ];

  setUp(() {
    mockLicenseBloc = MockLicenseBloc();
    licenseStreamController = StreamController<LicenseState>.broadcast();
    when(() => mockLicenseBloc.state).thenReturn(LicenseInitial());

    when(
      () => mockLicenseBloc.stream,
    ).thenAnswer((_) => licenseStreamController.stream);
  });

  tearDown(() {
    licenseStreamController.close();
  });

  group('UserBloc watch LicenseBloc Test', () {
    blocTest<UserBloc, UserFormSubmissionState>(
      'nên cập nhật state khi LicenseBloc thay đổi sang LicenseLoaded',
      build: () {
        return UserBloc(licenseBloc: mockLicenseBloc);
      },
      act: (bloc) {
        // Đẩy state mới vào stream để UserBloc nhận được
        licenseStreamController.add(
          LicenseLoaded(licenses: tLicenses, selectedLicense: tLicenses.last),
        );
      },
      wait: const Duration(milliseconds: 100),
      expect: () => [
        isA<UserFormSubmissionState>()
            .having((s) => s.license, 'hạng bằng', LicenseType.b)
            .having((s) => s.licenseError, 'lỗi', isNull),
      ],
    );

    blocTest<UserBloc, UserFormSubmissionState>(
      'nên tự cập nhật ngay khi khởi tạo nếu LicenseBloc đã có dữ liệu',
      build: () {
        // Stub lại state ĐÃ LOAD TRƯỚC khi UserBloc được tạo
        when(() => mockLicenseBloc.state).thenReturn(
          LicenseLoaded(licenses: tLicenses, selectedLicense: tLicenses.last),
        );
        return UserBloc(licenseBloc: mockLicenseBloc);
      },
      // Logic này chạy trong constructor nên không cần 'act'
      expect: () => [
        isA<UserFormSubmissionState>().having(
          (s) => s.license,
          'khởi tạo đúng',
          LicenseType.b,
        ),
      ],
    );
  });
}
