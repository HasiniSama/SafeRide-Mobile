import 'package:flutter/material.dart';
import 'package:safe_ride_mobile/screens/home/ChildHomeScreen.dart';
import 'package:safe_ride_mobile/screens/home/DriverHome.dart';

import 'package:safe_ride_mobile/screens/home/HomeScreen.dart';
import 'package:safe_ride_mobile/screens/parent/AbsentCalender.dart';
import 'package:safe_ride_mobile/screens/payment/CardDetails.dart';
import 'package:safe_ride_mobile/screens/payment/PaymentDetails.dart';
import 'package:safe_ride_mobile/screens/payment/SelectBus.dart';
import 'package:safe_ride_mobile/screens/payment/SelectCard.dart';
import 'package:safe_ride_mobile/screens/profile/ChildProfile.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DriverHome(),
    );
  }
}
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // initializeCSRF();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title, style: const TextStyle(color: appColors.kLightBlue)),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//           ],
//         ),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
