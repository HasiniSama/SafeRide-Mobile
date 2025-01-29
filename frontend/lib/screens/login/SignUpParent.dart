import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../main.dart';
import '../../widgets/PopUp.dart';
import '../../widgets/buttons.dart';
import '../../widgets/customFont.dart';
import '../../widgets/formField.dart';
import '../../widgets/transparentRectangle.dart';

class SignUpParentPage extends StatelessWidget {

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nicController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  SignUpParentPage({super.key});

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
                                height: 888.0,
                                borderRadius: 25.0,
                              ),
                              Positioned(
                                top: 47.0,
                                left: 32.0,
                                width: 261.0,
                                height: 888.0,
                                child: Column(
                                  children: [
                                    const CustomText(text: 'Parent Sign Up', fontSize: 25),
                                    const SizedBox(height: 30),
                                    LabeledFormField(
                                      labelText: 'First Name',
                                      controller: firstNameController,
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                    const SizedBox(height: 30),
                                    LabeledFormField(
                                      labelText: 'Last Name',
                                      controller: lastNameController,
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                    const SizedBox(height: 30),
                                    LabeledFormField(
                                      labelText: 'Email',
                                      controller: emailController,
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                    const SizedBox(height: 30),
                                    LabeledFormField(
                                      labelText: 'NIC No.',
                                      controller: nicController,
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                    const SizedBox(height: 30),
                                    LabeledFormField(
                                      labelText: 'Mobile',
                                      controller: mobileController,
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                    const SizedBox(height: 30),
                                    LabeledFormField(
                                      labelText: 'Password',
                                      controller: passController,
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                    const SizedBox(height: 30),
                                    LabeledFormField(
                                      labelText: 'Confirm Password',
                                      controller: confirmPassController,
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          ElevatedButton(
                            key: const Key('signupparentButton'),
                            style: AppButtonsStyle.blueButtonStyle,
                            onPressed: () {
                              registerNewUser(context);
                            },
                            child: const CustomText(text: 'Sign Up', fontSize: 24),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            style: AppButtonsStyle.lightBlueButtonStyle,
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: const CustomText(text: 'Cancel', fontSize: 24),
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

    // Perform form validation
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
        email: emailController.text,
        password: passController.text,
      );

      if (credential!=null){
        //Save User data into database
        Map userDataMap = {
          "firstName": firstNameController.text.trim(),
          "lastName": lastNameController.text.trim(),
          "email": emailController.text.trim(),
          "nic": nicController.text.trim(),
          "mobile": mobileController.text.trim(),
          "role" : 'parent',
        };
        usersRef.child(credential.user!.uid).set(userDataMap);
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
                Navigator.pushReplacementNamed(context, '/login'); // Navigate to home on button press
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

  String? validateFormFields() {
    // Check if any of the required fields are empty
    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        nicController.text.isEmpty ||
        mobileController.text.isEmpty ||
        passController.text.isEmpty ||
        confirmPassController.text.isEmpty) {
      return 'All fields are required';
    }

    // Check if password and confirm password match
    if (passController.text != confirmPassController.text) {
      return 'Passwords do not match';
    }

    // Check password length
    if (passController.text.length < 6) {
      return 'Password should be at least 6 characters';
    }

    // Check if email contains '@'
    if (!emailController.text.contains('@')) {
      return 'Invalid email address';
    }
    return null;
  }
}
