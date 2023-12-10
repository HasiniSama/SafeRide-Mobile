import 'package:flutter/material.dart';
import 'package:safe_ride_mobile/const/appColors.dart';
import 'package:safe_ride_mobile/screens/home/MapScreen.dart';
import 'package:safe_ride_mobile/widgets/IconSquare.dart';
import 'package:safe_ride_mobile/widgets/NavBar.dart';
import 'package:safe_ride_mobile/widgets/profile.dart';

class ChildHomeScreen extends StatefulWidget {
  const ChildHomeScreen({
    super.key,
  });

  @override
  State<ChildHomeScreen> createState() => _ChildHomeScreenState();
}

class _ChildHomeScreenState extends State<ChildHomeScreen> {
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
              child: ProfileCard(
                name: 'john doe',
                email: '',
              ),
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
                    name: 'Home',
                  ),
                  IconSquare(
                    navigator: '',
                    icon: Icon(
                      Icons.add_circle,
                    ),
                    name: 'School',
                  ),
                ],
              ),
            ),
            Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 32.0, vertical: 10.0),
                child: const Divider(
                  height: 2.0,
                  color: appColors.kBlue2,
                )),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Row(
                children: const <Widget>[
                  IconSquare(
                    navigator: '',
                    icon: Icon(
                      Icons.search,
                    ),
                    name: 'Find Busses',
                  ),
                  IconSquare(
                    navigator: '',
                    icon: Icon(
                      Icons.calendar_today_outlined,
                    ),
                    name: 'Bus Details',
                  ),
                ],
              ),
            ),
            Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 32.0, vertical: 10.0),
                child: const Divider(
                  height: 2.0,
                  color: appColors.kBlue2,
                )),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Row(
                children: const <Widget>[
                  IconSquare(
                    navigator: '',
                    icon: Icon(
                      Icons.compare_arrows,
                    ),
                    name: 'Edit Profile',
                  ),
                  IconSquare(
                    navigator: '',
                    icon: Icon(
                      Icons.account_balance,
                    ),
                    name: 'Calender',
                  ),
                ],
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.only(left: 32.0, bottom: 50.0, right: 32.0),
              child: Row(
                children: const <Widget>[
                  IconSquare(
                    navigator: '',
                    icon: Icon(
                      Icons.edit_square,
                    ),
                    name: 'Transaction History',
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
