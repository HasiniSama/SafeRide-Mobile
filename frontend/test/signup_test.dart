import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:safe_ride_mobile/screens/login/Login.dart';
import 'package:safe_ride_mobile/screens/login/SignUpDriver.dart';
import 'package:safe_ride_mobile/screens/login/SignUpParent.dart';
import 'package:safe_ride_mobile/screens/login/SignUpRole.dart';

void main() {
  group('Navigation Tests', () {
    testWidgets('Login page redirects to signup', (WidgetTester tester) async {

      // Build the MaterialApp with LoginPage.
      await tester.pumpWidget(
        MaterialApp(
          routes: {
            '/': (context) => LoginPage(),
            '/sign_up_role': (context) => const SignUpRolePage(),
          },
        ),
      );

      // Verify the text on the LoginPage widget.
      expect(find.text('Sign Up'), findsOneWidget);

      // Tap the Sign Up button.
      await tester.tap(find.text('Sign Up'));

      // Trigger a frame to process the button press and navigation.
      await tester.pumpAndSettle();

      // Verify that the signup page is displayed.
      expect(find.byType(SignUpRolePage), findsOneWidget);
    });

    testWidgets('Signup page redirects to login', (WidgetTester tester) async {
      // Build the MaterialApp with SignUpRolePage.
      await tester.pumpWidget(
        MaterialApp(
          initialRoute: '/',
          routes: {
            '/': (context) => LoginPage(),
            '/sign_up_role': (context) => const SignUpRolePage(),
          },
        ),
      );

      expect(find.byType(LoginPage), findsOneWidget);

      //Goto signup
      await tester.tap(find.text('Sign Up'));
      await tester.pumpAndSettle();
      expect(find.byType(SignUpRolePage), findsOneWidget);

      // Assuming there's a button on the SignUpRolePage that redirects to login:
      await tester.tap(find.text('Log In'));

      // Trigger a frame to process the button press and navigation.
      await tester.pumpAndSettle();

      // Verify that the login page is displayed.
      expect(find.byType(LoginPage), findsOneWidget);
    });

    testWidgets('Redirect to Parent Signup page', (WidgetTester tester) async {
      // Build the MaterialApp with SignUpRolePage.
      await tester.pumpWidget(
        MaterialApp(
          routes: {
            '/': (context) => const SignUpRolePage(),
            '/sign_up_parent': (context) => SignUpParentPage(),
          },
        ),
      );

      expect(find.byType(SignUpRolePage), findsOneWidget);

      //Goto parent signup
      await tester.tap(find.text('A Parent'));
      await tester.pumpAndSettle();
      expect(find.byType(SignUpParentPage), findsOneWidget);
      expect(find.text('Parent Sign Up'), findsOneWidget);
    });

    testWidgets('Redirect to Driver Signup page', (WidgetTester tester) async {
      // Build the MaterialApp with SignUpRolePage.
      await tester.pumpWidget(
        MaterialApp(
          routes: {
            '/': (context) => const SignUpRolePage(),
            '/sign_up_driver': (context) => SignUpDriverPage(),
          },
        ),
      );

      expect(find.byType(SignUpRolePage), findsOneWidget);

      //Goto parent signup
      expect(find.text('Choose your role'), findsOneWidget);
      await tester.tap(find.text('A Driver'));
      await tester.pumpAndSettle();
      expect(find.byType(SignUpDriverPage), findsOneWidget);
      expect(find.text('Driver Sign Up'), findsOneWidget);
    });
  });
}
