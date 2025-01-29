import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:safe_ride_mobile/screens/login/SignUpDriverDoc.dart';
import 'package:safe_ride_mobile/screens/login/SignUpParent.dart';
import 'package:safe_ride_mobile/widgets/PopUp.dart';

void main() {
  testWidgets('validateFormFields returns correct validation messages',
          (WidgetTester tester) async {

        tester.view.devicePixelRatio = 1;
        tester.view.physicalSize = const Size(1200, 1500);

        // Build the MaterialApp with LoginPage.
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SignUpParentPage(),
            ),
          ),
        );

        await tester.pumpAndSettle();

        // final emailFieldFinder = find.byKey(Key('emailField'));
        // final passwordFieldFinder = find.byKey(Key('passwordField'));
        final signupparentButtonFinder = find.byKey(Key('signupparentButton'));

        // Fill in the email and password fields
        await tester.tap(signupparentButtonFinder);
        await tester.pumpAndSettle();

        expect(find.byType(BottomPopupBar), findsOneWidget);
        expect(find.text('All fields are required'), findsOneWidget);

        expect(find.text('Ok'), findsOneWidget);
        await tester.pumpAndSettle();

        // await tester.enterText(emailFieldFinder, 'lahiru@gmail.com');
        // await tester.pumpAndSettle();
        //
        // expect(find.byType(BottomPopupBar), findsOneWidget);
        // expect(find.text('All fields are required'), findsOneWidget);
        //
        // expect(find.text('Ok'), findsOneWidget);
        // await tester.pumpAndSettle();
        //
        // await tester.enterText(emailFieldFinder, '');
        // await tester.enterText(passwordFieldFinder, '123456');
        // await tester.pumpAndSettle();
        //
        // expect(find.byType(BottomPopupBar), findsOneWidget);
        // expect(find.text('All fields are required'), findsOneWidget);
      });
}
