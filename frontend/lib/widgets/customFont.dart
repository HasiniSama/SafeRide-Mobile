import 'package:flutter/material.dart';

// Custom Text Component with customizable font size
class CustomText extends StatelessWidget {

  final String text;
  final double fontSize; // Parameter for font size
  final Color? color;

  const CustomText({
    Key? key,
    required this.text,
    this.fontSize = 20.0,
    this.color, // Optional color parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Open Sans',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w700,
        fontSize: fontSize,
        height: 1.0,
        color: color ?? Colors.white,
      ),
    );
  }
}
