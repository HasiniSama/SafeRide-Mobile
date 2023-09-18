import 'package:flutter/material.dart';
import 'package:safe_ride_mobile/const/appColors.dart';

class CustomInputField extends StatelessWidget {

  final TextEditingController controller;
  final String labelText;
  final String exampleText;

  const CustomInputField(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.exampleText});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15.0, top: 8.0),
          child: Text(
            labelText,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Container(
            width: 260.0,
            margin: const EdgeInsets.symmetric(vertical: 5.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                hintText: exampleText,
                hintStyle: const TextStyle(
                  fontSize: 16.0,
                  color: appColors.kBlue2,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

//
// final TextEditingController _textController2 = TextEditingController();
//
//
// CustomInputField(
// controller: _textController2,
// labelText: 'Input 2',
// ),
