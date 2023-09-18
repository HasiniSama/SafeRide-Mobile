import 'package:flutter/material.dart';
import 'package:safe_ride_mobile/const/appColors.dart';
import 'package:safe_ride_mobile/screens/home/MapScreen.dart';
import 'package:safe_ride_mobile/widgets/IconSquare.dart';
import 'package:safe_ride_mobile/widgets/NavBar.dart';
import 'package:safe_ride_mobile/widgets/profile.dart';

class DriverHome extends StatefulWidget {
  const DriverHome({
    super.key,
  });

  @override
  State<DriverHome> createState() => _DriverHomeState();
}

class _DriverHomeState extends State<DriverHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const CustomAppBar(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              padding: EdgeInsets.zero,
              child: ProfileCard(name: 'john doe', email: 'trytyjgku@gmail.com',),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Row(
                children: const <Widget>[
                  IconSquare(
                    navigator: '',
                    icon: Icon(
                      Icons.home,
                    ),
                    name: 'Edit Profile',
                  ),
                  IconSquare(
                    navigator: '',
                    icon: Icon(
                      Icons.add_circle,
                    ),
                    name: 'Bus Details',
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Row(
                children: const <Widget>[
                  IconSquare(
                    navigator: '',
                    icon: Icon(
                      Icons.search,
                    ),
                    name: 'Transaction history',
                  ),
                  IconSquare(
                    navigator: '',
                    icon: Icon(
                      Icons.calendar_today_outlined,
                    ),
                    name: 'Bank Details',
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Row(
                children: const <Widget>[
                  IconSquare(
                    navigator: '',
                    icon: Icon(
                      Icons.compare_arrows,
                    ),
                    name: 'Calendar',
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 50.0,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      appColors.kBlueGreenGra1,
                      appColors.kBlueGreenGra2
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Icon(
                        Icons.arrow_circle_left,
                        color: Colors.white,
                        size: 35, // Icon color
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      'Back', // Your text label
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: MapScreen(),
    );
  }
}