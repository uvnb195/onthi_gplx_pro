import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:onthi_gplx_pro/features/user_management/presentation/bloc/user/user_bloc.dart';
import 'package:onthi_gplx_pro/features/user_management/presentation/widgets/onboarding_steps/welcome_step.dart';

class MockUserBloc extends Mock implements UserBloc {}

void main() {
  late MockUserBloc mockUserBloc;

  setUp(() {
    mockUserBloc = MockUserBloc();
    when(() => mockUserBloc.state).thenReturn(UserFormSubmissionState());

    when(
      () => mockUserBloc.stream,
    ).thenAnswer((_) => Stream.fromIterable([UserFormSubmissionState()]));
  });

  testWidgets('should show textfield after animation completes', (
    widgetTester,
  ) async {
    await widgetTester.pumpWidget(
      MaterialApp(
        home: BlocProvider<UserBloc>.value(
          value: mockUserBloc,
          child: Scaffold(body: WelcomeStep()),
        ),
      ),
    );

    await widgetTester.pump(const Duration(seconds: 4));

    expect(find.byKey(Key('welcomeTextField')), findsOneWidget);
  });
}
