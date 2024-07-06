import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../widgets/PopUp.dart';
import '../../widgets/buttons.dart';
import '../../widgets/customFont.dart';
import '../../widgets/formField.dart';
import '../../widgets/transparentRectangle.dart';
import '../../const/appColors.dart';

class LoginPage extends StatelessWidget {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  LoginPage({super.key});

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
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
                            Navigator.pushNamed(context, '/sign_up_role');
                          },
                          style: AppButtonsStyle.transparentButtonStyle,
                          icon: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 20,
                          ),
                          label: const CustomText(text: "Sign Up", fontSize: 14),
                        ),
                      ),
                    ),
                    Center(child: Column(
                      children: [
                        Image.asset(
                          'assets/bus.png',
                          width: 160,
                          height: 160,
                          alignment: Alignment.center,
                        ),
                        const SizedBox(height: 30),
                        Image.asset(
                          'assets/logo.png',
                          width: 188,
                          height: 65,
                          alignment: Alignment.center,
                        ),
                        const SizedBox(height: 33),
                        Stack(
                          children: [
                            const TransparentRectangle(
                              width: 325.0,
                              height: 345.0,
                              borderRadius: 25.0,
                            ),
                            Positioned(
                              top: 35.0,
                              left: 32.0,
                              width: 261.0,
                              height: 351.0,
                              child: Column(
                                children: [
                                  const CustomText(text: 'Log In', fontSize: 25),
                                  const SizedBox(height: 30),
                                  LabeledFormField(
                                      labelText: 'Username / Email',
                                      controller: emailController,
                                      keyboardType: TextInputType.emailAddress,
                                  ),
                                  const SizedBox(height: 30),
                                  LabeledFormField(
                                    labelText: 'Password',
                                    controller: passController,
                                  ),
                                  const SizedBox(height: 8),
                                  const Align(
                                    alignment: Alignment.centerRight,
                                    child: Text("Forgot password?",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: appColors.kBlue2,
                                      ),
                                    ),
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
                            loginUser(context);
                          },
                          child: const CustomText(text: 'Log In', fontSize: 24),
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

  Future<void> loginUser(BuildContext context) async {
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
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passController.text
      );

      final uid = credential.user!.uid;
      DatabaseReference userRef = FirebaseDatabase.instance.reference().child('users').child(uid);

      userRef.get().then((DataSnapshot snapshot) {
        if (snapshot.exists) {
          Map userData = snapshot.value as Map;
          String role = userData['role'];
          if (role == 'parent') {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (role == 'driver') {
            Navigator.pushReplacementNamed(context, '/driver_home');
          } else {
            Navigator.pushReplacementNamed(context, '/error');
          }
        } else {
          // Handle case where user data is not found
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return BottomPopupBar(
                isError: true,
                imageUrl: 'assets/error.png',
                title: 'Login Failed!',
                buttonText: 'Ok',
                description: 'User data not found.',
                onPressed: () {
                  Navigator.pop(context);
                },
              );
            },
          );
        }
      }).catchError((error) {
        // Handle error retrieving user data
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return BottomPopupBar(
              isError: true,
              imageUrl: 'assets/error.png',
              title: 'Login Failed!',
              buttonText: 'Ok',
              description: 'Error retrieving user data: $error',
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        );
      });
    } on FirebaseAuthException catch (e) {
      String errorMessage = '';
      if (e.code == 'invalid-credential') {
        errorMessage = 'Either username or password is incorrect.';
      } else {
        print(e.code);
        errorMessage = 'Login failed. Please try again.';
      }
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return BottomPopupBar(
            isError: true,
            imageUrl: 'assets/error.png',
            title: 'Login Failed!',
            buttonText: 'Ok',
            description: errorMessage,
            onPressed: () {
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
            title: 'Login Failed!',
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

  String? validateFormFields() {
    // Check if any of the required fields are empty
    if (emailController.text.isEmpty ||
        passController.text.isEmpty) {
      return 'All fields are required';
    }
    return null;
  }
}
