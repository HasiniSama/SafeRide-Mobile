import 'package:flutter/material.dart';
import 'package:safe_ride_mobile/const/appColors.dart';
import 'package:safe_ride_mobile/screens/home/MapScreen.dart';
import 'package:safe_ride_mobile/widgets/IconSquare.dart';
import 'package:safe_ride_mobile/widgets/NavBar.dart';
import 'package:safe_ride_mobile/widgets/profile.dart';
import 'package:safe_ride_mobile/screens/profile/ParentProfile.dart';

class HomePage extends StatefulWidget {

  final VoidCallback logout;

  const HomePage({required this.logout, Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                name: 'dtcfyvgubhinj',
                email: 'tcyvubinm@gmail.com',
              ),
            ),
            Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Row(
                  children: const <Widget>[
                    IconSquare(
                      navigator: '/child_home',
                      icon: Icon(
                        Icons.accessibility,
                      ),
                      name: 'Child 01',
                    ),
                    IconSquare(
                      navigator: '/child_profile',
                      icon: Icon(
                        Icons.accessibility,
                      ),
                      name: 'Child 02',
                    ),
                    IconSquare(
                      navigator: '/child_profile',
                      icon: Icon(
                        Icons.accessibility,
                      ),
                      name: 'Child 02',
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Row(
                children: const <Widget>[
                  IconSquare(
                    navigator: '',
                    icon: Icon(
                      Icons.add_circle,
                    ),
                    name: 'Add Child',
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
                    navigator: '/bus_list',
                    icon: Icon(
                      Icons.search,
                    ),
                    name: 'Find Busses',
                  ),
                  IconSquare(
                    navigator: '/absent_calender',
                    icon: Icon(
                      Icons.calendar_today_outlined,
                    ),
                    name: 'Calender',
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
                    name: 'Transection History',
                  ),
                  IconSquare(
                    navigator: '/payment',
                    icon: Icon(
                      Icons.account_balance,
                    ),
                    name: 'Bank Cards',
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
                    name: 'Edit Profile',
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 50.0,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
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
            ),
          ],
        ),
      ),
      body: MapScreen(),
    );
  }
}
