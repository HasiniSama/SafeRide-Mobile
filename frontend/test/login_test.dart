import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:safe_ride_mobile/screens/login/Login.dart';
import 'package:safe_ride_mobile/widgets/PopUp.dart';

void main() {
  testWidgets('validateFormFields returns correct validation messages',
          (WidgetTester tester) async {

    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(1200, 800);

    // Build the MaterialApp with LoginPage.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: LoginPage(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    final emailFieldFinder = find.byKey(Key('emailField'));
    final passwordFieldFinder = find.byKey(Key('passwordField'));
    final loginButtonFinder = find.byKey(Key('loginButton'));

    // Fill in the email and password fields
    await tester.tap(loginButtonFinder);
    await tester.pumpAndSettle();

    expect(find.byType(BottomPopupBar), findsOneWidget);
    expect(find.text('All fields are required'), findsOneWidget);

    expect(find.text('Ok'), findsOneWidget);
    await tester.pumpAndSettle();

    await tester.enterText(emailFieldFinder, 'lahiru@gmail.com');
    await tester.pumpAndSettle();

    expect(find.byType(BottomPopupBar), findsOneWidget);
    expect(find.text('All fields are required'), findsOneWidget);

    expect(find.text('Ok'), findsOneWidget);
    await tester.pumpAndSettle();

    await tester.enterText(emailFieldFinder, '');
    await tester.enterText(passwordFieldFinder, '123456');
    await tester.pumpAndSettle();

    expect(find.byType(BottomPopupBar), findsOneWidget);
    expect(find.text('All fields are required'), findsOneWidget);
  });

    testWidgets('Login form validation', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginPage()));

      final loginPageState = tester.state<
          LoginPageState>(find.byType(LoginPage)) as LoginPageState;

      // Access and modify controllers
      loginPageState.emailController.text = 'john.doe@example.com';
      loginPageState.passController.text = 'password123';

      // Validate form
      final validationMessage = loginPageState.validateFormFields();
      expect(validationMessage, isNull);
    });
  }

