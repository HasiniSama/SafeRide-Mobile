import 'package:flutter/material.dart';
import '../../widgets/PopUp.dart';
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
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return BottomPopupBar(
                                  imageUrl: 'assets/correct.png',
                                  title: 'Request Sent!',
                                  description: "Our admins will check and respond to your offer within 2-3 business days",
                                  buttonText: 'Ok',
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                );
                              },
                            );
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
}
