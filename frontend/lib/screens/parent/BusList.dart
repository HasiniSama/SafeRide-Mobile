import 'package:flutter/material.dart';
import 'package:safe_ride_mobile/const/appColors.dart';
import 'package:safe_ride_mobile/widgets/list.dart';

class BusList extends StatefulWidget {
  const BusList({
    super.key,
  });

  @override
  State<BusList> createState() => _BusListState();
}

class _BusListState extends State<BusList> {
  final TextEditingController _startLocationController =
      TextEditingController();
  final TextEditingController _endLocationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/buslistBG.png',
          ),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                      margin: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: appColors.kBlue2,
                          width: 1.0,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.arrow_back,
                          size: 40.0,
                          color: appColors.kBlue2,
                        ),
                      ),
                      ),
                    ),
                  ],
                ),
                Text(
                  'List Of Busses',
                  style: TextStyle(color: Colors.white, fontSize: 32),
                ),
                Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50.0, vertical: 10.0),
                    child: const Divider(
                      height: 4.0,
                      color: appColors.kBlue2,
                    )),
                Container(
                  width: 325.0,
                  margin: const EdgeInsets.only(top: 60.0, bottom: 10.0),
                  padding: const EdgeInsets.only(top: 40.0, bottom: 30.0),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Container(
                          width: 260.0,
                          margin: const EdgeInsets.symmetric(vertical: 5.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: TextFormField(
                            controller: _startLocationController,
                            decoration: InputDecoration(
                              hintText: 'Start Location',
                              hintStyle: const TextStyle(
                                fontSize: 16.0,
                                color: appColors.kBlue2,
                              ),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Container(
                          width: 260.0,
                          margin: const EdgeInsets.symmetric(vertical: 5.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: TextFormField(
                            controller: _endLocationController,
                            decoration: InputDecoration(
                              hintText: 'Destination',
                              hintStyle: const TextStyle(
                                fontSize: 16.0,
                                color: appColors.kBlue2,
                              ),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, right: 30.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          // Adjust the alignment as needed
                          child: ElevatedButton(
                              onPressed: () {
                                // Add your button's functionality here
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: appColors.kBlue2,
                                fixedSize: const Size(160, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    'Search    ',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  Icon(
                                    Icons.search,
                                    // Replace with the desired icon
                                    color: Colors.white,
                                    size: 28,
                                  ),
                                ],
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 325.0,
                  margin: const EdgeInsets.only(top: 60.0, bottom: 10.0),
                  padding: const EdgeInsets.symmetric(
                      vertical: 30.0, horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      List(
                        image: 'assets/profile_image.jpg',
                        name: 'rt',
                        status: 'rety',
                      ),
                      List(
                        image: 'assets/profile_image.jpg',
                        name: 'rt',
                        status: 'rety',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
