import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_ride_mobile/screens/home/ChildHomeScreen.dart';
import 'package:safe_ride_mobile/screens/home/DriverHome.dart';
import 'package:safe_ride_mobile/screens/home/HomeScreen.dart';
import 'package:safe_ride_mobile/screens/home/MapScreen.dart';
import 'package:safe_ride_mobile/screens/login/Login.dart';
import 'package:safe_ride_mobile/screens/login/SignUpDriver.dart';
import 'package:safe_ride_mobile/screens/login/SignUpDriverDoc.dart';
import 'package:safe_ride_mobile/screens/login/SignUpParent.dart';
import 'package:safe_ride_mobile/screens/login/SignUpRole.dart';
import 'package:safe_ride_mobile/screens/parent/AbsentCalender.dart';
import 'package:safe_ride_mobile/screens/parent/BusList.dart';
import 'package:safe_ride_mobile/screens/payment/PaymentDetails.dart';
import 'package:safe_ride_mobile/screens/profile/ChildProfile.dart';
import 'package:safe_ride_mobile/screens/profile/ParentProfile.dart';
import 'package:safe_ride_mobile/providers/location_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:safe_ride_mobile/screens/firebase/FirebaseAdd.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LocationProvider(),
          child: MapScreen(),
        )
      ],
      child: MaterialApp(
          title: 'Safe Ride App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          // home: HomePage(logout: logout),
          home: LoginPage(),
          routes: {
            '/home': (context) => const HomePage(),
            '/parent_profile': (context) => const ParentProfile(),
            '/driver_home': (context) => const DriverHome(),
            '/absent_calender': (context) => const AbsentCalender(),
            '/child_profile': (context) => const ChildProfile(),
            '/child_home': (context) => const ChildHomeScreen(),
            '/bus_list': (context) => const BusList(),
            '/payment': (context) => const PaymentDetails(),
            '/login': (context) => LoginPage(),
            '/sign_up_role': (context) => const SignUpRolePage(),
            '/sign_up_parent': (context) => SignUpParentPage(),
            '/sign_up_driver': (context) => SignUpDriverPage(),
            '/sign_up_driver_doc': (context) => SignUpDriverDocPage(),
            '/firebase_add': (context) => const FirebaseAdd(),
          }),
    );
  }
}
