import 'package:flutter/material.dart';
import '../../widgets/PopUp.dart';
import '../../widgets/buttons.dart';
import '../../widgets/customFont.dart';
import '../../widgets/formField.dart';
import '../../widgets/transparentRectangle.dart';
import 'SignUpDriverDoc.dart';

class SignUpDriverPage extends StatelessWidget {

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nicController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  SignUpDriverPage({super.key});

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
                                    const CustomText(text: 'Driver Sign Up', fontSize: 25),
                                    const SizedBox(height: 30),
                                    LabeledFormField(
                                      key: const Key('driverfirstname'),
                                      labelText: 'First Name',
                                      controller: firstNameController,
                                      keyboardType: TextInputType.name,
                                    ),
                                    const SizedBox(height: 30),
                                    LabeledFormField(
                                      key: const Key('driverlastname'),
                                      labelText: 'Last Name',
                                      controller: lastNameController,
                                      keyboardType: TextInputType.name,
                                    ),
                                    const SizedBox(height: 30),
                                    LabeledFormField(
                                      key: const Key('driveremail'),
                                      labelText: 'Email',
                                      controller: emailController,
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                    const SizedBox(height: 30),
                                    LabeledFormField(
                                      key: const Key('drivernic'),
                                      labelText: 'NIC No.',
                                      controller: nicController,
                                      keyboardType: TextInputType.number,
                                    ),
                                    const SizedBox(height: 30),
                                    LabeledFormField(
                                      key: const Key('drivermobile'),
                                      labelText: 'Mobile',
                                      controller: mobileController,
                                      keyboardType: TextInputType.phone,
                                    ),
                                    const SizedBox(height: 30),
                                    LabeledFormField(
                                      key: const Key('driverpassword'),
                                      labelText: 'Password',
                                      controller: passController,
                                      keyboardType: TextInputType.visiblePassword,
                                    ),
                                    const SizedBox(height: 30),
                                    LabeledFormField(
                                      key: const Key('driverconpassword'),
                                      labelText: 'Confirm Password',
                                      controller: confirmPassController,
                                      keyboardType: TextInputType.visiblePassword,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          ElevatedButton(
                            key: const Key('driverbtn'),
                            style: AppButtonsStyle.blueButtonStyle,
                            onPressed: () {

                              String? validationMessage = validateFormFields();
                              if (validationMessage != null) {
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUpDriverDocPage(
                                    firstName: firstNameController.text,
                                    lastName: lastNameController.text,
                                    email: emailController.text,
                                    nic: nicController.text,
                                    mobile: mobileController.text,
                                    pass: passController.text
                                  ),
                                ),
                              );
                            },
                            child: const CustomText(text: 'Next', fontSize: 24),
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

  String? validateFormFields() {

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
    return null; // No validation errors
  }
}
