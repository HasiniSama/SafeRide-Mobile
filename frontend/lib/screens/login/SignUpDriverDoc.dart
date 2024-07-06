import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../../main.dart';
import '../../widgets/PopUp.dart';
import '../../widgets/buttons.dart';
import '../../widgets/customFont.dart';
import '../../widgets/transparentRectangle.dart';
import '../../widgets/uploadFormField.dart';

class SignUpDriverDocPage extends StatefulWidget {

  final String firstName;
  final String lastName;
  final String email;
  final String nic;
  final String mobile;
  final String pass;

  SignUpDriverDocPage({super.key, required this.firstName,
    required this.lastName, required this.email, required this.nic,
    required this.mobile, required this.pass});

  @override
  State<SignUpDriverDocPage> createState() => _SignUpDriverDocPageState();
}

class _SignUpDriverDocPageState extends State<SignUpDriverDocPage> {

  final TextEditingController drivingLicenseController = TextEditingController();
  final TextEditingController nicController = TextEditingController();
  final TextEditingController vehicleRegistrationController = TextEditingController();

  @override
  void dispose() {
    drivingLicenseController.dispose();
    nicController.dispose();
    vehicleRegistrationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/loginBG.png',
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children:[
                const SizedBox(height: 50),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      style: AppButtonsStyle.transparentButtonStyle,
                      icon: const Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                      label: const CustomText(text: "Log In", fontSize: 14),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 27),
                  child: Center(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            const TransparentRectangle(
                              width: 325.0,
                              height: 700.0,
                              borderRadius: 25.0,
                            ),
                            Positioned(
                              top: 47.0,
                              left: 32.0,
                              width: 261.0,
                              height: 888.0,
                              child: Column(
                                children: [
                                  const CustomText(text: 'Driver Sign Up', fontSize: 25),
                                  const SizedBox(height: 10),
                                  const CustomText(text: 'Documentation', fontSize: 14),
                                  const SizedBox(height: 30),
                                  FileUploadFormField(
                                    labelText: 'Driving License',
                                    controller: drivingLicenseController,
                                    maxWidth: 260,
                                    height: 150,
                                  ),
                                  const SizedBox(height: 30),
                                  FileUploadFormField(
                                    labelText: 'National Identity Card',
                                    controller: nicController,
                                    maxWidth: 260,
                                    height: 150,
                                  ),
                                  const SizedBox(height: 30),
                                  FileUploadFormField(
                                    labelText: 'Vehicle Registration',
                                    controller: vehicleRegistrationController,
                                    maxWidth: 260,
                                    height: 150,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          style: AppButtonsStyle.blueButtonStyle,
                          onPressed: () {
                            registerNewUser(context);
                          },
                          child: const CustomText(text: 'Submit', fontSize: 24),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          style: AppButtonsStyle.lightBlueButtonStyle,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const CustomText(text: 'Back', fontSize: 24),
                        ),
                        const SizedBox(height: 75),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> registerNewUser(BuildContext context) async {

    //Perform form validation
    String? validationMessage = validateFormFields();

    if (validationMessage != null) {
      // Show error popup if validation fails
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return BottomPopupBar(
            isError: true,
            imageUrl: 'assets/error.png',
            title: 'Validation Error!',
            buttonText: 'Ok',
            description: validationMessage,
            onPressed: () {
              Navigator.pop(context);
            },
          );
        },
      );
      return; // Exit function if validation fails
    }

    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: widget.email,
        password: widget.pass,
      );

      if (credential!=null){

        String uid = credential.user!.uid;

        // String drivingLicenseUrl = await uploadFileToFirebaseStorage(drivingLicenseController.text, uid, 'driving_license');
        // String nicFileUrl = await uploadFileToFirebaseStorage(nicController.text, uid, 'nic');
        // String vehicleRegistrationUrl = await uploadFileToFirebaseStorage(vehicleRegistrationController.text, uid, 'vehicle_registration');

        //Save User data into database
        Map userDataMap = {
          "firstName": widget.firstName.trim(),
          "lastName": widget.lastName.trim(),
          "email": widget.email.trim(),
          "nic": widget.nic.trim(),
          "mobile": widget.mobile.trim(),
          "role": 'driver',
          // "drivingLicenseUrl": drivingLicenseUrl,
          // "nicFileUrl": nicFileUrl,
          // "vehicleRegistrationUrl": vehicleRegistrationUrl
        };
        usersRef.child(uid).set(userDataMap);
      }
      // Registration successful
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return BottomPopupBar(
            imageUrl: 'assets/correct.png',
            title: 'Registration Complete!',
            buttonText: 'Log In',
            onPressed: () {
              // Navigator.pushNamed(context, '/home'); // Navigate to home on button press
            },
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      // Firebase registration failed
      String errorMessage = '';
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      } else {
        errorMessage = 'Registration failed. Please try again.';
      }
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return BottomPopupBar(
            isError: true,
            imageUrl: 'assets/error.png',
            title: 'Registration Failed!',
            buttonText: 'Ok',
            description: errorMessage,
            onPressed: (){
              Navigator.pop(context);
            },
          );
        },
      );
      print(errorMessage); // Print error message for debugging
    } catch (e) {
      // Other errors
      print('Error: $e');

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return BottomPopupBar(
            isError: true,
            imageUrl: 'assets/error.png',
            title: 'Registration Failed!',
            buttonText: 'Ok',
            description: 'Error: $e',
            onPressed: (){
              Navigator.pop(context);
            },
          );
        },
      );
    }
  }

  Future<String> uploadFileToFirebaseStorage(String filePath, String uid, String fileName) async {

    if (filePath.isNotEmpty) {
      File file = File(filePath);

      if (!file.existsSync()) {
        print('File does not exist: $filePath');
        throw Exception('File does not exist at path: $filePath');
      }

      try {
        int length = await file.length();
        print('File length: $length');

        Reference storageRef = FirebaseStorage.instance.ref().child('users/$uid/$fileName');
        UploadTask uploadTask = storageRef.putFile(file);
        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();
        return downloadUrl;
      } catch (e) {
        print('Error uploading $fileName: $e');
        throw Exception('Failed to upload $fileName');
      }
    } else {
      throw Exception('File path is empty');
    }
  }

  String? validateFormFields() {

    if (drivingLicenseController.text.isEmpty ||
        nicController.text.isEmpty ||
        vehicleRegistrationController.text.isEmpty) {
      return 'All document fields are required';
    }
    return null;
  }
}
