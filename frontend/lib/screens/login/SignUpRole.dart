import 'package:flutter/material.dart';
import '../../widgets/buttons.dart';
import '../../widgets/customFont.dart';
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
                  const SizedBox(height: 100),
                  Center(
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
                              height: 371.0,
                              child: Column(
                                children: [
                                  const CustomText(text: 'Choose your role', fontSize: 25),
                                  const SizedBox(height: 50),
                                  const CustomText(text: 'Are you a', fontSize: 20),
                                  const SizedBox(height: 40),
                                  ElevatedButton(
                                    style: AppButtonsStyle.blueButtonStyle,
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/sign_up_parent');
                                    },
                                    child: const CustomText(text: 'A Parent', fontSize: 24),
                                  ),
                                  const SizedBox(height: 40),
                                  const CustomText(text: 'or', fontSize: 20),
                                  const SizedBox(height: 40),
                                  ElevatedButton(
                                    style: AppButtonsStyle.whiteButtonStyle,
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/sign_up_driver');
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
                ],
            ),
          ),
        ],
      ),
    );
  }
}
