import 'package:flutter/material.dart';

// Custom Text Component with customizable font size
class CustomText extends StatelessWidget {

  final String text;
  final double fontSize; // Parameter for font size

  const CustomText({super.key,
    required this.text,
    this.fontSize = 20.0, // Default font size
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Open Sans',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w700,
        fontSize: fontSize, // Use the provided fontSize parameter
        height: 1.0, // Adjust line height as needed
        color: Colors.white,
      ),
    );
  }
}
