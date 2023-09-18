import 'package:flutter/material.dart';
import 'package:safe_ride_mobile/const/appColors.dart';
import 'package:safe_ride_mobile/widgets/buttons.dart';
import 'package:safe_ride_mobile/widgets/inputField.dart';
import 'package:safe_ride_mobile/widgets/profile.dart';

class ChildProfile extends StatefulWidget {
  const ChildProfile({
    super.key,
  });

  @override
  State<ChildProfile> createState() => _ChildProfileState();
}

class _ChildProfileState extends State<ChildProfile> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _addressController1 = TextEditingController();
  final TextEditingController _addressController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset(
              'assets/childProfileBackground.png',
            ),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
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
                        controller: _firstNameController,
                        labelText: 'First Name',
                        exampleText: 'First Name',
                      ),
                      CustomInputField(
                        controller: _lastNameController,
                        labelText: 'Last Name',
                        exampleText: 'Last Name',
                      ),
                      CustomInputField(
                        controller: _addressController1,
                        labelText: 'Address',
                        exampleText: 'Address Line 1',
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Container(
                          width: 260.0,
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: TextFormField(
                            controller: _addressController2,
                            decoration: InputDecoration(
                              hintText: "Address Line 2",
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
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 60.0, bottom: 20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Add your button's functionality here
                    },
                    style: AppButtonsStyle.blueButtonStyle,
                    child: const Text('Save',
                        style:
                        TextStyle(color: Colors.white, fontSize: 24)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 60.0),
                  child: ElevatedButton(
                  onPressed: () {
                    // Add your button's functionality here
                  },
                  style: AppButtonsStyle.lightBlueButtonStyle,
                  child: const Text('Cancel',
                      style:
                      TextStyle(color: Colors.black, fontSize: 24)),
                ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
