import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../widgets/buttons.dart';
import '../../widgets/customFont.dart';
import '../../widgets/formField.dart';
import '../../widgets/transparentRectangle.dart';
import '../../const/appColors.dart';

class SignUpRolePage extends StatelessWidget {

  const SignUpRolePage({super.key});

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
          Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      const TransparentRectangle(
                        width: 325.0,
                        height: 413.0,
                        borderRadius: 25.0,
                      ),
                      Positioned(
                        top: 47.0,
                        left: 32.0,
                        width: 261.0,
                        height: 351.0,
                        child: Column(
                          children: [
                            const CustomText(text: 'Choose your role', fontSize: 25),
                            const SizedBox(height: 50),
                            const CustomText(text: 'Are you a', fontSize: 20),
                            const SizedBox(height: 40),
                            ElevatedButton(
                              style: AppButtonsStyle.blueButtonStyle,
                              onPressed: () {
                                // Handle login button press
                                // Typically, you might navigate to another page or perform authentication
                              },
                              child: const CustomText(text: 'A Parent', fontSize: 24),
                            ),
                            const SizedBox(height: 40),
                            const CustomText(text: 'or', fontSize: 20),
                            const SizedBox(height: 40),
                            ElevatedButton(
                              style: AppButtonsStyle.whiteButtonStyle,
                              onPressed: () {
                                // Handle login button press
                                // Typically, you might navigate to another page or perform authentication
                              },
                              child: const CustomText(
                                  text: 'A Driver',
                                  fontSize: 24,
                                  color: appColors.kBlue2,
                              ),
                            ),
                            const SizedBox(height: 8),

                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
