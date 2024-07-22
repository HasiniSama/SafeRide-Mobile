import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_ride_mobile/Assitant/assistantMethods.dart';
import 'package:safe_ride_mobile/Assitant/locationData.dart';
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
  final TextEditingController _endLocationController = TextEditingController();
  late List<Map<String, dynamic>> suitableDrivers = [];
  final FocusNode _endLocationFocus = FocusNode();

  String selectedDistrict = 'Ampara';
  List<School> schoolsList = [];
  School? selectedSchool;

  @override
  void dispose() {
    _endLocationFocus.dispose(); // Dispose the FocusNode
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _fetchSchools();
  }

  @override
  Widget build(BuildContext context) {
    final String? selectedChild = Provider.of<SelectedChildProvider>(context, listen: false).selectedChildId;

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
                          child: DropdownButton<String>(
                            value: selectedDistrict,
                            items: LocationData.districts.map((String district) {
                              return DropdownMenuItem<String>(
                                value: district,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Text(district),
                                ),
                              );
                            }).toList(),
                            isExpanded: true,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedDistrict = newValue!;
                                _fetchSchools();
                              });
                            },
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
                          child: DropdownButton<School>(
                            value: selectedSchool,
                            hint: const Text('Select School'),
                            items: schoolsList.map((School school) {
                              return DropdownMenuItem<School>(
                                value: school,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Text(school.name),
                                ),
                              );
                            }).toList(),
                            isExpanded: true,
                            onChanged: (School? newValue) {
                              setState(() {
                                selectedSchool = newValue;
                              });
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, right: 30.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed: () async {
                              if(selectedSchool != null){
                                List<Map<String, dynamic>> drivers = await AssistantMethods.findSuitableDrivers(selectedDistrict, selectedSchool!);
                                setState(() {
                                  _endLocationFocus.unfocus();
                                  suitableDrivers = drivers;
                                });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: appColors.kBlue2,
                              fixedSize: const Size(160, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                            child: const Row(
                              children: [
                                Text(
                                  'Search    ',
                                  style: TextStyle(color: Colors.white, fontSize: 20),
                                ),
                                Icon(
                                  Icons.search,
                                  color: Colors.white,
                                  size: 28,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                suitableDrivers.isEmpty
                    ? Container(
                  width: 325.0,
                  margin: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                  padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: const Center(
                    child: Text(
                      'No suitable drivers found.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                )
                    : Container(
                  width: 325.0,
                  margin: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                  padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ...suitableDrivers.map((driverData) {
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
                                        await _updateChild(selectedChild!, driverData['busId']);
                                        Navigator.of(context).pop();
                                      },
                                      child:  const Text('Add vehicle'),
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
                              status: 'Available Sheets : ${driverData['busCapacity']}',
                            ),
                          ),
                        );
                      }).toList(),
                      Container(
                        height: 2.0, // Adjust height as needed
                        color: Colors.white,
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

  Future<void> _fetchSchools() async {
    DatabaseReference schoolsRef = FirebaseDatabase.instance.reference()
        .child('schoolsBaseOnDistricts')
        .child(selectedDistrict);
    schoolsRef.once().then((DatabaseEvent event) {
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.value != null) {
        var snapshotValue = snapshot.value;
        if (snapshotValue is List) {
          List<School> fetchedSchoolsList = snapshotValue
              .whereType<Map>()
              .map((item) => School.fromMap(item))
              .toList();
          setState(() {
            schoolsList = fetchedSchoolsList;
            selectedSchool = schoolsList.isNotEmpty ? schoolsList.first : null;
          });
        } else {
          print('Error: Data is not in the expected format.');
        }
      } else {
        setState(() {
          schoolsList = [];
          selectedSchool = null;
        });
      }
    }).catchError((error) {
      print('Error fetching schools: $error');
    });
  }

  Future<void> _updateChild(String childKey, String busId) async {
    try {
      DatabaseReference childRef = FirebaseDatabase.instance.reference()
          .child('children')
          .child(childKey);

      await childRef.update({
        'selectedBusId': busId,
      });

      DatabaseReference busRef = FirebaseDatabase.instance.reference()
          .child('busses')
          .child(busId);

      DataSnapshot busSnapshot = await busRef.child('children').get();
      List<dynamic> childrenList = [];
      if (busSnapshot.exists && busSnapshot.value != null) {
        childrenList = List<dynamic>.from(busSnapshot.value as List<dynamic>);
      }

      if (!childrenList.contains(childKey)) {
        childrenList.add(childKey);
      }

      await busRef.update({
        'children': childrenList,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bus assigned successfully!')),
      );
    } catch (e) {
      print('Error updating child record: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to assign bus.')),
      );
    }
  }
}
