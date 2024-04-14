import 'package:flutter/material.dart';
import '../../widgets/buttons.dart';
import '../../widgets/customFont.dart';
import '../../widgets/transparentRectangle.dart';
import '../../widgets/uploadFormField.dart';

class SignUpDriverDocPage extends StatelessWidget {

  final TextEditingController emailController = TextEditingController();

  SignUpDriverDocPage({super.key});

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
          Positioned(
            top: 40, // Adjust this value for vertical positioning
            right: 20, // Adjust this value for horizontal positioning
            child: ElevatedButton.icon(
              onPressed: () {
                // Handle button press
              },
              style: AppButtonsStyle.transparentButtonStyle,
              icon: const Icon(
                Icons.arrow_forward,
                color: Colors.white,
                size: 20,
              ),
              label: const CustomText(text: "Log In", fontSize: 14),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 120),
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
                                controller: TextEditingController(),
                                maxWidth: 260,
                                height: 150,
                              ),
                              const SizedBox(height: 30),
                              FileUploadFormField(
                                labelText: 'National Identity Card',
                                controller: TextEditingController(),
                                maxWidth: 260,
                                height: 150,
                              ),
                              const SizedBox(height: 30),
                              FileUploadFormField(
                                labelText: 'Vehicle Registration',
                                controller: TextEditingController(),
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
                        // Handle login button press
                        // Typically, you might navigate to another page or perform authentication
                      },
                      child: const CustomText(text: 'Submit', fontSize: 24),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: AppButtonsStyle.lightBlueButtonStyle,
                      onPressed: () {
                        // Handle login button press
                        // Typically, you might navigate to another page or perform authentication
                      },
                      child: const CustomText(text: 'Back', fontSize: 24),
                    ),
                    const SizedBox(height: 75),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
