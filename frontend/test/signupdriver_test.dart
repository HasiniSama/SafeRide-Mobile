import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:safe_ride_mobile/screens/login/SignUpDriver.dart';
import 'package:safe_ride_mobile/widgets/PopUp.dart';

void main() {
  testWidgets('validateFormFields returns correct validation messages',
          (WidgetTester tester) async {

        tester.view.devicePixelRatio = 1;
        tester.view.physicalSize = const Size(1200, 1200);

        // Build the MaterialApp with LoginPage.
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SignUpDriverPage(),
            ),
          ),
        );

        await tester.pumpAndSettle();

        final driverfirstnameFinder = find.byKey(Key('driverfirstname'));
        final driverlastnameFinder = find.byKey(Key('driverlastname'));
        final driveremailFinder = find.byKey(Key('driveremail'));
        final drivernicFinder = find.byKey(Key('drivernic'));
        final drivermobileFinder = find.byKey(Key('drivermobile'));
        final driverpasswordFinder = find.byKey(Key('driverpassword'));
        final driverconpasswordFinder = find.byKey(Key('driverconpassword'));
        final driverbtnFinder = find.byKey(Key('driverbtn'));


        // Fill in the email and password fields
        await tester.tap(driverbtnFinder);
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