import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_ride_mobile/Assitant/assistantMethods.dart';
import 'package:safe_ride_mobile/const/appColors.dart';
import '../../AllWidgets/ListWidget.dart';
import '../../models/school.dart';
import '../../providers/selected.child.dart';

class BusList extends StatefulWidget {
  const BusList({Key? key}) : super(key: key);

  @override
  State<BusList> createState() => _BusListState();
}

class _BusListState extends State<BusList> {
  late List<Map<String, dynamic>> suitableDrivers = [];
  late String childrenID;
  late dynamic childrenData;

  @override
  void initState() {
    super.initState();
    childrenID = Provider.of<SelectedChildProvider>(context, listen: false).selectedChildId!;
    _fetchChildrenData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fromRect(
            rect: Rect.fromCenter(
              center: Offset(MediaQuery.of(context).size.width / 2, MediaQuery.of(context).size.height / 2),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            child: Image.asset(
              'assets/buslistBG.png',
              fit: BoxFit.cover,
            ),
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
                const Text(
                  'List Of Buses',
                  style: TextStyle(color: Colors.white, fontSize: 32),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
                  child: const Divider(
                    height: 4.0,
                    color: appColors.kBlue2,
                  ),
                ),
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
                          child: Text('District: ${childrenData['district']}'),
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
                          child: Text('School: ${childrenData['school']['name']}'),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 325.0,
                  margin: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                  padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: suitableDrivers.isEmpty
                      ? const Center(
                    child: Text(
                      'No suitable drivers found.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  )
                      : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: suitableDrivers.map((driverData) {
                      return GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Driver Details'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Driver ID: ${driverData['driverId'] ?? 'Unknown'}'),
                                    Text('District: ${driverData['district'] ?? 'Unknown'}'),
                                    Text('Bus Number: ${driverData['busNumber'] ?? 'Unknown'}'),
                                    Text('Starting Point: ${driverData['startingPoint']['locationName'] ?? 'Unknown'}'),
                                    Text('Ending Point: ${driverData['endingPoint']['locationName'] ?? 'Unknown'}'),
                                    Text('Bus Capacity: ${driverData['busCapacity'] ?? 'Unknown'}'),
                                    Text('Schools: ${(driverData['schools'] as List<dynamic>?)?.join(', ') ?? 'Unknown'}'),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () async {
                                      // Ensure you pass the starting point data to the _updateChild function
                                      await _updateChild(childrenID, driverData['busId'], childrenData['tripStartingLocation']['lat'].toString(), childrenData['tripStartingLocation']['lng'].toString(), context);
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Add vehicle'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Close'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListWidget(
                            image: driverData['image'] ?? 'assets/profile_image.jpg',
                            name: driverData['startingPoint'] != null && driverData['endingPoint'] != null
                                ? '${driverData['startingPoint']['locationName']} - ${driverData['endingPoint']['locationName']}'
                                : 'Unknown',
                            status: 'Available Seats: ${driverData['busCapacity']}',
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _fetchChildrenData() async {
    DatabaseReference childrenRef = FirebaseDatabase.instance.reference()
        .child('children')
        .child(childrenID);

    childrenRef.once().then((DatabaseEvent event) {
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.value != null) {
        setState(() {
          childrenData = snapshot.value;
        });
        _fetchSuitableDrivers();
      }
    });
  }

  Future<void> _fetchSuitableDrivers() async {
    if (childrenData != null) {
      List<Map<String, dynamic>> drivers = await AssistantMethods.findSuitableDrivers(childrenData['district'], School.fromMap(childrenData['school']));
      setState(() {
        suitableDrivers = drivers;
      });
    }
  }

  Future<void> _updateChild(String childKey, String busId, String startingPointLat, String startingPointLng, BuildContext context) async {
    try {
      DatabaseReference childRef = FirebaseDatabase.instance.reference()
          .child('children')
          .child(childKey);

      await childRef.update({
        'selectedBusId': busId
      });

      DatabaseReference busRef = FirebaseDatabase.instance.reference()
          .child('busses')
          .child(busId);

      await busRef.child('children').child(childKey).update({'startingLocation': {
        'lat': startingPointLat,
        'lng': startingPointLng,
      }});
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Child updated successfully!')),
      );
    } catch (error) {
      print(error);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update child: $error')),
      );
    }
  }
}
