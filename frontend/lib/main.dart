import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_ride_mobile/screens/home/ChildHomeScreen.dart';
import 'package:safe_ride_mobile/screens/home/DriverHome.dart';
import 'package:safe_ride_mobile/screens/home/HomeScreen.dart';
import 'package:safe_ride_mobile/screens/home/MapScreen.dart';
import 'package:safe_ride_mobile/screens/login/Login.dart';
import 'package:safe_ride_mobile/screens/parent/AbsentCalender.dart';
import 'package:safe_ride_mobile/screens/parent/BusList.dart';
import 'package:safe_ride_mobile/screens/payment/PaymentDetails.dart';
import 'package:safe_ride_mobile/screens/profile/ChildProfile.dart';
import 'package:safe_ride_mobile/screens/profile/ParentProfile.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:safe_ride_mobile/providers/location_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:safe_ride_mobile/screens/firebase/FirebaseAdd.dart';
import 'firebase_options.dart';

final FlutterAppAuth flutterAppAuth = FlutterAppAuth();

const clientId = '0uefCc9YcaAuxnkEDWGjZ16jYWsa';
const redirectUrl = 'wso2.asgardeo.saferide://login-callback';
const discoveryUrl =
    'https://api.asgardeo.io/t/hasinisama2/oauth2/token/.well-known/openid-configuration';
const userInfoEndpoint =
    'https://api.asgardeo.io/t/hasinisama2/oauth2/userinfo';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool _isUserLoggedIn;
  late String? _idToken;
  late String? _accessToken;
  late String? _firstName;
  late String? _lastName;
  late String? _dateOfBirth;
  late String? _country;
  late String? _mobile;
  late String? _photo;

  @override
  void initState() {
    super.initState();
    _isUserLoggedIn = false;
    _idToken = '';
    _accessToken = '';
  }

  Future<void> login() async {
    try {
      final AuthorizationTokenResponse? result =
          await flutterAppAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          clientId,
          redirectUrl,
          discoveryUrl: discoveryUrl,
          promptValues: ['login'],
          scopes: ['openid', 'profile'],
        ),
      );

      setState(() {
        _isUserLoggedIn = true;
        _idToken = result?.idToken;
        _accessToken = result?.accessToken;
      });
    } catch (e, s) {
      print('Error while login to the system: $e - stack: $s');
      setState(() {
        _isUserLoggedIn = false;
      });
    }
  }

  Future<void> retrieveUserDetails() async {
    final userInfoResponse = await http.get(
      userInfoEndpoint as Uri,
      headers: {'Authorization': 'Bearer $_accessToken'},
    );

    if (userInfoResponse.statusCode == 200) {
      var profile = jsonDecode(userInfoResponse.body);
      setState(() {
        _firstName = profile['given_name'];
        _lastName = profile['family_name'];
        _dateOfBirth = profile['birthdate'];
        _country = profile['address']['country'];
        _mobile = profile['phone_number'];
        _photo = profile['picture'];
      });
    } else {
      throw Exception('Failed to get user profile information');
    }
  }

  // Method to handle logout process
  void logout() async {
    try {
      final EndSessionResponse? result = await flutterAppAuth.endSession(
        EndSessionRequest(
          idTokenHint: _idToken,
          postLogoutRedirectUrl: redirectUrl,
          discoveryUrl: discoveryUrl,
        ),
      );

      setState(() {
        _isUserLoggedIn = false;
      });
    } catch (e, s) {
      print('Error while logout from the system: $e - stack: $s');
    }
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
          home: _isUserLoggedIn ? HomePage(logout: logout) : LoginPage(login: login),
          routes: {
            '/home': (context) => HomePage(logout: logout),
            '/parent_profile': (context) => const ParentProfile(),
            '/driver_home': (context) => const DriverHome(),
            '/absent_calender': (context) => const AbsentCalender(),
            '/child_profile': (context) => const ChildProfile(),
            '/child_home': (context) => const ChildHomeScreen(),
            '/bus_list': (context) => const BusList(),
            '/payment': (context) => const PaymentDetails(),
            '/login': (context) => LoginPage(login: login),
            '/firebase_add': (context) => const FirebaseAdd(),
          }),
    );
  }
}
