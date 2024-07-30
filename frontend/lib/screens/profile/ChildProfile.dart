import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:safe_ride_mobile/const/appColors.dart';
import 'package:safe_ride_mobile/widgets/buttons.dart';
import 'package:safe_ride_mobile/widgets/inputField.dart';
import 'package:safe_ride_mobile/widgets/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Assitant/assistantMethods.dart';
import '../../Assitant/locationData.dart';
import '../../models/school.dart';
import '../../widgets/PopUp.dart';
import '../../widgets/dropdownField.dart';

class ChildProfile extends StatefulWidget {
  const ChildProfile({
    super.key,
  });

  @override
  State<ChildProfile> createState() => _ChildProfileState();
}

class _ChildProfileState extends State<ChildProfile> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _startLocationController = TextEditingController();

  bool _isLoading = false;

  String selectedDistrict = 'Ampara';
  List<School> schoolsList = [];
  School? selectedSchool;
  late Map<String, dynamic> _startingPoint;

  @override
  void initState() {
    super.initState();
    _fetchSchools();
  }

  // void _fetchSchools() async {
  //   DatabaseReference ref = FirebaseDatabase.instance.ref('schools');
  //   DataSnapshot snapshot = await ref.get();
  //   if (snapshot.exists) {
  //     List<String> fetchedSchools = [];
  //     for (var school in snapshot.children) {
  //       fetchedSchools.add(school.child('name').value.toString());
  //     }
  //     setState(() {
  //       _schools = fetchedSchools;
  //     });
  //   }
  // }

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

  Future<void> _handleSubmit() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? parentId = prefs.getString('uid');

    if (parentId == null || _nameController.text.isEmpty ) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return BottomPopupBar(
            isError: true,
            imageUrl: 'assets/error.png',
            title: 'Validation Error!',
            buttonText: 'Ok',
            description: 'Please fill all the required fields.',
            onPressed: () {
              Navigator.pop(context);
            },
          );
        },
      );
      return; // Exit function if validation fails
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Get school ID based on selected school name
      // DatabaseReference schoolRef = FirebaseDatabase.instance.ref('schools');
      // DataSnapshot schoolSnapshot = await schoolRef.get();
      // String? schoolId;
      // if (schoolSnapshot.exists) {
      //   for (var school in schoolSnapshot.children) {
      //     if (school.child('name').value.toString() == selectedSchool?.name) {
      //       schoolId = school.key;
      //       break;
      //     }
      //   }
      // }
      //
      // if (schoolId == null) {
      //   // Handle error if school ID is not found
      //   throw Exception('School ID not found');
      // }

      // Save child data to Firebase Realtime Database
      DatabaseReference childrenRef = FirebaseDatabase.instance.ref('children').push();
      await childrenRef.set({
        'name': _nameController.text,
        'district': selectedDistrict,
        'school': selectedSchool?.toMap(),
        'parentId': parentId,
        'tripStartingLocation': _startingPoint
      });

      setState(() {
        _isLoading = false;
      });

      // Show success message
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return BottomPopupBar(
            isError: false,
            imageUrl: 'assets/success.png',
            title: 'Success!',
            buttonText: 'Ok',
            description: 'Child profile saved successfully.',
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
          );
        },
      );
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      // Handle errors
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return BottomPopupBar(
            isError: true,
            imageUrl: 'assets/error.png',
            title: 'Submission Failed!',
            buttonText: 'Ok',
            description: 'Error: $error',
            onPressed: () {
              Navigator.pop(context);
            },
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Image.asset(
            'assets/childProfileBackground.png',
          ),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: appColors.kBlue2,
                            width: 1.0,
                          ),
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
                  url: 'assets/childProfile.jpg',
                  isEditable: true,
                ),
                Container(
                  width: 325.0,
                  margin: const EdgeInsets.only(top: 60.0, bottom: 10.0),
                  padding: const EdgeInsets.only(top: 20.0, bottom: 30.0),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomInputField(
                        controller: _nameController,
                        labelText: 'Name',
                        exampleText: 'Enter Child Name',
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
                      TypeAheadField<String>(
                        textFieldConfiguration: TextFieldConfiguration(
                          controller: _startLocationController,
                          decoration: const InputDecoration(
                            labelText: 'Search Start Location',
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
                        hideSuggestionsOnKeyboardHide: false,
                        keepSuggestionsOnSuggestionSelected: false,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0, bottom: 20.0),
                  child: ElevatedButton(
                    onPressed: _handleSubmit,
                    style: AppButtonsStyle.blueButtonStyle,
                    child: const Text('Save',
                        style: TextStyle(color: Colors.white, fontSize: 24)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 60.0),
                  child: _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: AppButtonsStyle.lightBlueButtonStyle,
                          child: const Text('Cancel',
                          style: TextStyle(color: Colors.black, fontSize: 24)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

// void addDummySchools() async {
//   DatabaseReference ref = FirebaseDatabase.instance.ref('schools');
//
//   List<Map<String, dynamic>> dummySchools = [
//     {'name': 'Asgiriwalpola Primary School', 'latitude': 7.114023022148411, 'longitude': 79.97748164590047},
//     {'name': 'Bandaranayake College', 'latitude': 7.099690340809983, 'longitude': 80.00791632751269},
//     {'name': 'Gothami Kanishta Vidyalaya', 'latitude': 7.093290049239819, 'longitude': 79.99147875930358},
//     {'name': 'Holy Cross College', 'latitude': 7.096594491709603, 'longitude': 80.00697574569466},
//     {'name': 'Lyceum International School', 'latitude': 7.111431654722575, 'longitude': 80.04356321401929},
//     {'name': 'Royal Institute International School', 'latitude': 7.098449971813372, 'longitude': 80.01881452751047},
//     {'name': 'Rathnavali Balika Vidyalaya', 'latitude': 7.091406120785588, 'longitude': 80.00226978537238},
//     {'name': 'Siddhartha Kumara Maha Vidyalaya', 'latitude': 7.098119173326842, 'longitude': 79.99443968205786},
//     {'name': 'Sri Bodhi Primary School', 'latitude': 7.096361595820207, 'longitude': 80.00925057752347},
//     {'name': 'St. Peter\'s College', 'latitude': 7.142603037330807, 'longitude': 79.98144030520437},
//     {'name': 'Sumedha College', 'latitude': 7.091085777031373, 'longitude': 79.99248909110584},
//     {'name': 'Thakshila College', 'latitude': 7.095011021290235, 'longitude': 80.01382685930375},
//     {'name': 'Yashodara Devi Balika', 'latitude': 7.096635196229226, 'longitude': 79.9932121365971},
//   ];
//
//   dummySchools.sort((a, b) => a['name'].compareTo(b['name']));
//
//   for (var school in dummySchools) {
//     await ref.push().set({
//       'name': school['name'],
//       'latitude': school['latitude'],
//       'longitude': school['longitude'],
//     });
//   }
//
//   print('Dummy schools added to Firebase.');
// }
}
