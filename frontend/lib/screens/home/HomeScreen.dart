import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:safe_ride_mobile/const/appColors.dart';
import 'package:safe_ride_mobile/screens/home/MapScreen.dart';
import 'package:safe_ride_mobile/widgets/IconSquare.dart';
import 'package:safe_ride_mobile/widgets/NavBar.dart';
import 'package:safe_ride_mobile/widgets/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/child.dart';

class HomePage extends StatefulWidget {

  const HomePage({ Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String? firstName;
  String? lastName;
  String? email;
  String? uid;
  List<Child> children = [];

  @override
  void initState() {
    
    super.initState();
    _loadUserData().then((_) {
      if (uid != null) {
        _loadChildrenData();
      }
    });
  }

  Future<void> _loadChildrenData() async {

    if (uid != null) {
      List<Child> fetchedChildren = await fetchChildrenFromDatabase(uid!);
      setState(() {
        children = fetchedChildren;
      });
      print(children.first.id);
      print("HIIIIIIIIIIIIIIII");
    }
  }

  Future<void> _loadUserData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        firstName = prefs.getString('firstName');
        lastName = prefs.getString('lastName');
        email = prefs.getString('email');
        uid = prefs.getString('uid');
      });
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

  Future<List<Child>> fetchChildrenFromDatabase(String parentId) async {

    DatabaseReference childrenRef = FirebaseDatabase.instance.ref('children');
    DataSnapshot snapshot = await childrenRef.orderByChild('parentId').equalTo(parentId).get();

    List<Child> children = [];
    if (snapshot.exists) {
      Map<dynamic, dynamic> childrenData = snapshot.value as Map<dynamic, dynamic>;
      childrenData.forEach((key, value) {
        children.add(Child.fromMap(Map<String, dynamic>.from(value), key));
      });
    }
    return children;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const CustomAppBar(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              padding: EdgeInsets.zero,
              child: firstName != null && lastName != null && email != null
                  ? ProfileCard(
                name: '$firstName $lastName',
                email: email!,
              )
              : const Center(child: CircularProgressIndicator()), // Loading indicator while data is being fetched
            ),
            Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Row(
                    children: <Widget>[
                      ...children.map((child) => IconSquare(
                        navigator: '/child_home',
                        icon: const Icon(Icons.accessibility),
                        name: child.name,
                        childId: child.id
                      )),
                      const IconSquare(
                        navigator: '/child_profile',
                        icon: Icon(
                          Icons.add_circle,
                        ),
                        name: 'Add Child',
                      ),
                    ],
                ),
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
              child: const Row(
                children: <Widget>[
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
              child: const Row(
                children: <Widget>[
                  IconSquare(
                    navigator: '',
                    icon: Icon(
                      Icons.compare_arrows,
                    ),
                    name: 'Transection History',
                  ),
                  IconSquare(
                    navigator: '/payhere',
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
              child: const Row(
                children: <Widget>[
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
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
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
