import 'package:flutter/material.dart';
import 'package:safe_ride_mobile/const/appColors.dart';
import '../../widgets/buttons.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
          // Centered content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon
                Image.asset(
                  'assets/busIcon.png',
                  width: 200,
                  height: 200,
                ),
                const SizedBox(height: 70),
                // Elevated button
                ElevatedButton(
                  style: AppButtonsStyle.blueButtonStyle,
                  onPressed: () {
                    // Handle login button press
                    // Typically, you might navigate to another page or perform authentication
                  },
                  child: const Text('Login'),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: AppButtonsStyle.lightBlueButtonStyle,
                  onPressed: () {
                    // Handle login button press
                    // Typically, you might navigate to another page or perform authentication
                  },
                  child: const Text('Sign Up'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
