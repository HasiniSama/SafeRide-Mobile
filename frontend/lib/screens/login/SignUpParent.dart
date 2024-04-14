import 'package:flutter/material.dart';
import '../../widgets/buttons.dart';
import '../../widgets/customFont.dart';
import '../../widgets/formField.dart';
import '../../widgets/transparentRectangle.dart';

class SignUpParentPage extends StatelessWidget {

  final TextEditingController emailController = TextEditingController();

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
                                      controller: emailController,
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                    const SizedBox(height: 30),
                                    LabeledFormField(
                                      labelText: 'Last Name',
                                      controller: emailController,
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
                                      controller: emailController,
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                    const SizedBox(height: 30),
                                    LabeledFormField(
                                      labelText: 'Mobile',
                                      controller: emailController,
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                    const SizedBox(height: 30),
                                    LabeledFormField(
                                      labelText: 'Password',
                                      controller: emailController,
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                    const SizedBox(height: 30),
                                    LabeledFormField(
                                      labelText: 'Confirm Password',
                                      controller: emailController,
                                      keyboardType: TextInputType.emailAddress,
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
}
