import 'package:flutter/material.dart';
import 'package:safe_ride_mobile/const/appColors.dart';

class AppButtonsStyle {

  static ButtonStyle lightBlueButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: appColors.kBlue1,
    minimumSize: const Size(260, 50),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25.0),
      side: const BorderSide(color: Colors.white, width: 2.0),
    ),
    textStyle: const TextStyle(color: appColors.kBlue2),
  );

  static ButtonStyle blueButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: appColors.kBlue2,
    foregroundColor: Colors.white,
    elevation: 4, // Shadow elevation
    padding: const EdgeInsets.symmetric(horizontal: 16), // Horizontal padding
    minimumSize: const Size(260, 50), // Button size
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25.0), // Rounded corners
      side: const BorderSide(
        color: appColors.kBlue2, // Border color
        width: 2.0, // Border width
      ),
    ),
  );

  static ButtonStyle popupButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    minimumSize: const Size(260, 50),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25.0),
    ),
    shadowColor: Colors.transparent,
  );
}

// ElevatedButton(
// onPressed: () {
// // Add your button's functionality here
// },
// style: AppButtonsStyle.blueButtonStyle, // Apply the custom style
// child: Text('Click Me', style: TextStyle(color: Colors.white)),
// ),
