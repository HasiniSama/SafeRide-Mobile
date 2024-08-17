import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_ride_mobile/Assitant/notification_service.dart';
import 'package:safe_ride_mobile/providers/selected.child.dart';
import 'package:safe_ride_mobile/screens/driver/DriverProfile.dart';
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
import 'package:safe_ride_mobile/screens/payment/SelectBus.dart';
import 'package:safe_ride_mobile/screens/profile/ChildProfile.dart';
import 'package:safe_ride_mobile/screens/profile/ParentProfile.dart';
import 'package:safe_ride_mobile/providers/location_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:safe_ride_mobile/screens/firebase/FirebaseAdd.dart';

final navigatorKey = GlobalKey<NavigatorState>();

// function to listen to background changes
Future _firebaseBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {
    print("Some notification Received in background...");
  }
}

// to handle notification on foreground on web platform
void showNotification({required String title, required String body}) {
  showDialog(
    context: navigatorKey.currentContext!,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(body),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Ok"))
      ],
    ),
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // initialize firebase messaging
  await PushNotification.init();
  await PushNotification.localNotiInit();

  // Listen to background notifications
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);

  // on background notification tapped
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if (message.notification != null) {
      print("Background Notification Tapped");
      navigatorKey.currentState!.pushNamed("/message", arguments: message);
    }
  });

// to handle foreground notifications
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    String payloadData = jsonEncode(message.data);
    print("Got a message in foreground");
    if (message.notification != null) {
      PushNotification.showSimpleNotification(
          title: message.notification!.title!,
          body: message.notification!.body!,
          payload: payloadData);
    }
  });

  // for handling in terminated state
  final RemoteMessage? message =
  await FirebaseMessaging.instance.getInitialMessage();

  if (message != null) {
    print("Launched from terminated state");
    Future.delayed(Duration(seconds: 1), () {
      navigatorKey.currentState!.pushNamed("/message", arguments: message);
    });
  }

  runApp(const MyApp());
}

DatabaseReference usersRef = FirebaseDatabase. instance. ref().child("users");

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
        ),
        ChangeNotifierProvider(create: (_) => SelectedChildProvider())
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
          '/driver_profile': (context) => const DriverProfile(),
          '/driver_home': (context) => const DriverHome(),
          '/absent_calender': (context) => const AbsentCalender(),
          '/child_profile': (context) => const ChildProfile(),
          '/child_home': (context) => const ChildHomeScreen(),
          '/bus_list': (context) => const BusList(),
          '/payment': (context) => const PaymentDetails(),
          '/payhere': (context) => const SelectBus(),
          '/login': (context) => LoginPage(),
          '/sign_up_role': (context) => const SignUpRolePage(),
          '/sign_up_parent': (context) => SignUpParentPage(),
          '/sign_up_driver': (context) => SignUpDriverPage(),
          '/firebase_add': (context) => const FirebaseAdd(),
        },
        navigatorKey: navigatorKey,
        onGenerateRoute: (settings) {
          if (settings.name == '/sign_up_driver_doc') {
            final args = settings.arguments as Map<String, String>;
            return MaterialPageRoute(
              builder: (context) => SignUpDriverDocPage(
                  firstName: args['firstName']!,
                  lastName: args['lastName']!,
                  email: args['email']!,
                  nic: args['nic']!,
                  mobile: args['mobile']!,
                  pass: args['pass']!),
            );
          }
          return null;
        },
      ),
    );
  }
}