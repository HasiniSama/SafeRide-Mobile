import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:safe_ride_mobile/Assitant/assistantMethods.dart';
import 'package:safe_ride_mobile/Assitant/locationData.dart';
import 'package:safe_ride_mobile/const/appColors.dart';
import 'package:safe_ride_mobile/widgets/buttons.dart';
import 'package:safe_ride_mobile/widgets/inputField.dart';

import '../../models/school.dart';
import '../../widgets/PopUp.dart';
import '../../widgets/profile.dart';

class DriverProfile extends StatefulWidget {
  const DriverProfile({Key? key}) : super(key: key);

  @override
  State<DriverProfile> createState() => _DriverProfileState();
}

class _DriverProfileState extends State<DriverProfile> {
  final TextEditingController _startLocationController = TextEditingController();
  final TextEditingController _endLocationController = TextEditingController();

  late Map<String, dynamic> _startingPoint;
  late Map<String, dynamic> _endingPoint;

  String selectedDistrict = 'Ampara';
  List<School> selectedSchools = [];
  List<School> schoolsList = [];

  @override
  void initState() {
    super.initState();
    _fetchSchools();  // Fetch initial schools for the default district
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/childProfileBackground.png',
            fit: BoxFit.cover,
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
                const ProfileEditCard(
                  url: 'assets/profile_image.jpg',
                  isEditable: false,
                ),
                Container(
                  width: 325.0,
                  margin: const EdgeInsets.only(top: 40.0, bottom: 20.0),
                  padding: const EdgeInsets.only(top: 20.0, bottom: 30.0),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Select District',
                        style: TextStyle(fontSize: 16),
                      ),
                      DropdownButton<String>(
                        value: selectedDistrict,
                        items: LocationData.districts.map((String district) {
                          return DropdownMenuItem<String>(
                            value: district,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10.0,
                              ),
                              child: Text(district),
                            ),
                          );
                        }).toList(),
                        isExpanded: true,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedDistrict = newValue!;
                            _fetchSchools();  // Fetch schools based on the selected district
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Schools Covered',
                        style: TextStyle(fontSize: 16),
                      ),
                      MultiSelectDialogField(
                        items: schoolsList.map((School school) {
                          return MultiSelectItem<School>(school, school.name);
                        }).toList(),
                        title: const Text("Schools"),
                        selectedColor: Colors.blue,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                        ),
                        buttonIcon: const Icon(
                          Icons.school,
                          color: Colors.blue,
                        ),
                        buttonText: const Text(
                          "Select Schools",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        onConfirm: (results) {
                          setState(() {
                            selectedSchools = results;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      TypeAheadField<String>(
                        textFieldConfiguration: TextFieldConfiguration(
                          controller: _startLocationController,
                          decoration: const InputDecoration(
                            labelText: 'Search Location',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        suggestionsCallback: (pattern) async {
                          return await AssistantMethods.getSuggestions(pattern);
                        },
                        itemBuilder: (context, suggestion) {
                          return ListTile(
                            title: Text(suggestion),
                          );
                        },
                        onSuggestionSelected: (suggestion) async {
                          _startLocationController.text = suggestion;
                          _startingPoint = await AssistantMethods.getPlaceDetails(suggestion);
                        },
                      ),
                      const SizedBox(height: 10),
                      TypeAheadField<String>(
                        textFieldConfiguration: TextFieldConfiguration(
                          controller: _endLocationController,
                          decoration: const InputDecoration(
                            labelText: 'Search Location',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        suggestionsCallback: (pattern) async {
                          return await AssistantMethods.getSuggestions(pattern);
                        },
                        itemBuilder: (context, suggestion) {
                          return ListTile(
                            title: Text(suggestion),
                          );
                        },
                        onSuggestionSelected: (suggestion) async {
                          _endLocationController.text = suggestion;
                          _endingPoint = await AssistantMethods.getPlaceDetails(suggestion);
                        },
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () {
                          _saveDriverData(context);
                        },
                        style: AppButtonsStyle.blueButtonStyle,
                        child: const Text(
                          'Save',
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: AppButtonsStyle.lightBlueButtonStyle,
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.black, fontSize: 24),
                        ),
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
            selectedSchools = [];
          });
        } else {
          print('Error: Data is not in the expected format.');
        }
      } else {
        setState(() {
          schoolsList = [];
          selectedSchools = [];
        });
      }
    }).catchError((error) {
      print('Error fetching schools: $error');
    });
  }

  Future<void> _saveDriverData(BuildContext context) async {
    try {
      DatabaseReference busRef = FirebaseDatabase.instance.reference().child('busses');
      List<Map<String, dynamic>> selectedSchoolsAsMaps = selectedSchools.map((school) => school.toMap()).toList();

      Map<String, dynamic> busData = {
        'driverId': FirebaseAuth.instance.currentUser!.uid,
        'district': selectedDistrict,
        'busNumber': 2342,
        'busCapacity': 1,
        'schools': selectedSchoolsAsMaps,
        'startingPoint': {
          'latitude': _startingPoint['lat'],
          'longitude': _startingPoint['lng'],
          'locationName': _startingPoint['locationName']
        },
        'endingPoint': {
          'latitude': _endingPoint['lat'],
          'longitude': _endingPoint['lng'],
          'locationName': _endingPoint['locationName']
        },
      };
      await busRef.push().set(busData);

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return BottomPopupBar(
            imageUrl: 'assets/correct.png',
            title: 'Registration Successful!',
            buttonText: 'Ok',
            onPressed: () {
              Navigator.pushNamed(context, '/driver_home');
            },
          );
        },
      );
    } catch (e) {
      print(e);
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return BottomPopupBar(
            isError: true,
            imageUrl: 'assets/error.png',
            title: 'Registration Failed!',
            buttonText: 'Ok',
            description: 'Error: $e',
            onPressed: () {
              Navigator.pop(context);
            },
          );
        },
      );
    }
  }
}
