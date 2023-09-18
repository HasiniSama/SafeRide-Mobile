import 'package:flutter/material.dart';
import 'package:safe_ride_mobile/const/appColors.dart';
import 'package:safe_ride_mobile/widgets/buttons.dart';
import 'package:safe_ride_mobile/widgets/inputField.dart';
import 'package:safe_ride_mobile/widgets/profile.dart';

class ParentProfile extends StatefulWidget {
  const ParentProfile({
    super.key,
  });

  @override
  State<ParentProfile> createState() => _ParentProfileState();
}

class _ParentProfileState extends State<ParentProfile> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _conformPasswordController = TextEditingController();
  final TextEditingController _addressController1 = TextEditingController();
  final TextEditingController _addressController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
        children: [
          Image.asset(
            'assets/parentProfileBackground.png',
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
                  url: 'assets/profile_image.jpg',
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
                        exampleText: 'First Name',
                      ),
                      CustomInputField(
                        controller: _lastNameController,
                        labelText: 'Last Name',
                        exampleText: 'Last Name',
                      ),
                      CustomInputField(
                        controller: _emailController,
                        labelText: 'Email',
                        exampleText: 'Email',
                      ),
                      CustomInputField(
                        controller: _mobileController,
                        labelText: ' Mobile',
                        exampleText: 'Mobile',
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
                            color: Colors.white, // Set the background color to white
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
                              contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                  Padding(
                    padding: const EdgeInsets.only(top: 60.0, bottom: 20.0),
                    child:ElevatedButton(
                        onPressed: () {
                          // Add your button's functionality here
                        },
                        style: AppButtonsStyle.blueButtonStyle,
                        child: const Text('Save',
                            style:
                                TextStyle(color: Colors.white, fontSize: 24)),
                      ),
                  ),
                  ElevatedButton(
                        onPressed: () {
                          // Add your button's functionality here
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
        ],
      ),
      ),
    );
  }
}
