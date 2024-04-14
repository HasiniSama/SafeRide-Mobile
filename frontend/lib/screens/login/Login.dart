import 'package:flutter/material.dart';
import '../../widgets/buttons.dart';
import '../../widgets/customFont.dart';
import '../../widgets/formField.dart';
import '../../widgets/transparentRectangle.dart';
import '../../const/appColors.dart';

class LoginPage extends StatelessWidget {

  final TextEditingController emailController = TextEditingController();

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
                                    controller: emailController,
                                    keyboardType: TextInputType.emailAddress,
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
                            // Handle login button press
                            // Typically, you might navigate to another page or perform authentication
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
}
