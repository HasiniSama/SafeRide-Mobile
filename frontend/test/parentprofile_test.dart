import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart'; // For mocking
import 'package:flutter/material.dart';
import 'package:safe_ride_mobile/screens/home/HomeScreen.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:safe_ride_mobile/screens/profile/ParentProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  testWidgets('_loadUserData loads user data correctly', (WidgetTester tester) async {
    final mockSharedPreferences = MockSharedPreferences();
    when(mockSharedPreferences.getString('firstName')).thenReturn('John');
    when(mockSharedPreferences.getString('lastName')).thenReturn('Doe');
    when(mockSharedPreferences.getString('email')).thenReturn('johndoe@example.com');
    when(mockSharedPreferences.getString('mobile')).thenReturn('1234567890');

    await tester.pumpWidget(MaterialApp(home: ParentProfile(sharedPreferences: mockSharedPreferences)));

    await tester.pumpAndSettle();

    expect(tester.state<ParentProfileState>(find.byType(ParentProfile)).firstName, 'John');
    expect(tester.state<ParentProfileState>(find.byType(ParentProfile)).lastName, 'Doe');
    expect(tester.state<ParentProfileState>(find.byType(ParentProfile)).email, 'johndoe@example.com');
    expect(tester.state<ParentProfileState>(find.byType(ParentProfile)).mobile, '1234567890');
  });
}



// void testLoadUserData() async {
//   final mockSharedPreferences = MockSharedPreferences();
//   when(mockSharedPreferences.getString('firstName')).thenReturn('John');
//   when(mockSharedPreferences.getString('lastName')).thenReturn('Doe');
//   when(mockSharedPreferences.getString('email')).thenReturn('johndoe@example.com');
//   when(mockSharedPreferences.getString('uid')).thenReturn('12345');
//
//   final homePage = HomePage(sharedPreferences: mockSharedPreferences);
//
//   await homePage._loadUserData();
//
//   expect(homePage.firstName, 'John');
//   expect(homePage.lastName, 'Doe');
//   expect(homePage.email, 'johndoe@example.com');
//   expect(homePage.uid, '12345');
// }
//
// // Test error handling in _loadUserData
// void testLoadUserData_Error() async {
//   final mockSharedPreferences = MockSharedPreferences();
//   when(mockSharedPreferences.getString('firstName')).thenThrow(Exception('SharedPreferences error'));
//
//   final homePage = HomePage(sharedPreferences: mockSharedPreferences);
//
//   await homePage._loadUserData();
//
//   // Expect no user data set
//   expect(homePage.firstName, null);
//   expect(homePage.lastName, null);
//   expect(homePage.email, null);
//   expect(homePage.uid, null);
// }
