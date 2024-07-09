import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safe_ride_mobile/const/appColors.dart';
import 'package:safe_ride_mobile/widgets/buttons.dart';
import 'package:safe_ride_mobile/widgets/inputField.dart';
import 'package:safe_ride_mobile/widgets/profile.dart';

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
  String _selectedSchool = '';
  List<String> _schools = [];

  @override
  void initState() {
    super.initState();
    _fetchSchools();
  }

  void _fetchSchools() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref('schools');
    DataSnapshot snapshot = await ref.get();
    if (snapshot.exists) {
      List<String> fetchedSchools = [];
      for (var school in snapshot.children) {
        fetchedSchools.add(school.child('name').value.toString());
      }
      setState(() {
        _schools = fetchedSchools;
      });
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      _schools.isEmpty
                          ? const CircularProgressIndicator()
                          : CustomDropdownField(
                        labelText: 'Select School',
                        items: _schools,
                        selectedItem: _selectedSchool,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedSchool = newValue!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0, bottom: 20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Add your button's functionality here
                    },
                    style: AppButtonsStyle.blueButtonStyle,
                    child: const Text('Save',
                        style: TextStyle(color: Colors.white, fontSize: 24)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 60.0),
                  child: ElevatedButton(
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
}
