import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:safe_ride_mobile/const/appColors.dart';
import 'package:safe_ride_mobile/widgets/buttons.dart';
import 'package:safe_ride_mobile/widgets/inputField.dart';
import 'package:safe_ride_mobile/widgets/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/PopUp.dart';

class ParentProfile extends StatefulWidget {
  final SharedPreferences sharedPreferences;

  const ParentProfile({
    super.key,
    required this.sharedPreferences,
  });

  @override
  State<ParentProfile> createState() => ParentProfileState();
}

class ParentProfileState extends State<ParentProfile> {

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _conformPasswordController = TextEditingController();
  final TextEditingController _addressController1 = TextEditingController();
  final TextEditingController _addressController2 = TextEditingController();

  String? firstName;
  String? lastName;
  String? email;
  String? mobile;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      firstName = widget.sharedPreferences.getString('firstName');
      lastName = widget.sharedPreferences.getString('lastName');
      email = widget.sharedPreferences.getString('email');
      mobile = widget.sharedPreferences.getString('mobile');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                  isEditable: true,
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomInputField(
                        controller: _firstNameController,
                        labelText: 'First Name',
                        exampleText: '$firstName',
                      ),
                      CustomInputField(
                        controller: _lastNameController,
                        labelText: 'Last Name',
                        exampleText: '$lastName',
                      ),
                      CustomInputField(
                        controller: _emailController,
                        labelText: 'Email',
                        exampleText: '$email',
                      ),
                      CustomInputField(
                        controller: _mobileController,
                        labelText: ' Mobile',
                        exampleText: '$mobile',
                      ),
                      CustomInputField(
                        controller: _passwordController,
                        labelText: 'New Password',
                        exampleText: 'New Password',
                      ),
                      CustomInputField(
                        controller: _conformPasswordController,
                        labelText: 'Confirm New Password',
                        exampleText: 'Confirm New Password',
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
                            // Set the background color to white
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
                      Padding(
                        padding: const EdgeInsets.only(top: 60.0, bottom: 20.0),
                        child: ElevatedButton(
                          onPressed: () {
                            updateUserDetails(context);
                          },
                          style: AppButtonsStyle.blueButtonStyle,
                          child: const Text('Save',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 24)),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: AppButtonsStyle.lightBlueButtonStyle,
                        child: const Text('Cancel',
                            style:
                                TextStyle(color: Colors.black, fontSize: 24)),
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

  Future<void> updateUserDetails(BuildContext context) async {

    // Create a map to hold updated data
    Map<String, String> updatedUserData = {};

    // Check if any controller has text and add it to the map
    if (_firstNameController.text.trim().isNotEmpty) {
      updatedUserData['firstName'] = _firstNameController.text.trim();
    }
    if (_lastNameController.text.trim().isNotEmpty) {
      updatedUserData['lastName'] = _lastNameController.text.trim();
    }
    if (_emailController.text.trim().isNotEmpty) {
      updatedUserData['email'] = _emailController.text.trim();
    }
    if (_mobileController.text.trim().isNotEmpty) {
      updatedUserData['mobile'] = _mobileController.text.trim();
    }

    // Check if password is not empty and validate it
    if (_passwordController.text.trim().isNotEmpty) {
      if (_passwordController.text != _conformPasswordController.text) {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return BottomPopupBar(
              isError: true,
              imageUrl: 'assets/error.png',
              title: 'Password Error!',
              buttonText: 'Ok',
              description: 'Passwords do not match.',
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        );
        return;
      } else {
        // updatedUserData['password'] = _passwordController.text.trim();
      } // Store hashed password instead
    }

    if (updatedUserData.isNotEmpty) {
      try {
        final uid = FirebaseAuth.instance.currentUser!.uid;
        DatabaseReference userRef = FirebaseDatabase.instance.reference().child('users').child(uid);

        // Update the user data in Firebase
        await userRef.update(updatedUserData);

        // Show success popup
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return BottomPopupBar(
              imageUrl: 'assets/correct.png',
              title: 'Update Successful!',
              buttonText: 'Ok',
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        );
      } catch (e) {
        // Handle errors
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return BottomPopupBar(
              isError: true,
              imageUrl: 'assets/error.png',
              title: 'Update Failed!',
              buttonText: 'Ok',
              description: 'Error: $e',
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        );
      }
    } else {
      // No updates were made
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return BottomPopupBar(
            isError: true,
            imageUrl: 'assets/error.png',
            title: 'Update Failed!',
            buttonText: 'Ok',
            description: 'No changes detected.',
            onPressed: () {
              Navigator.pop(context);
            },
          );
        },
      );
    }
  }
}
