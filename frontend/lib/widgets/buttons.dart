import 'package:flutter/material.dart';
import 'package:safe_ride_mobile/const/appColors.dart';

class AppButtonsStyle {

  static ButtonStyle lightBlueButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: appColors.kBlue1,
    foregroundColor: Colors.white,
    elevation: 2, // Shadow elevation
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

  static ButtonStyle blueButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: appColors.kBlue2,
    foregroundColor: Colors.white,
    elevation: 2, // Shadow elevation
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

  static ButtonStyle whiteButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    foregroundColor: appColors.kBlue2,
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

  static ButtonStyle transparentButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.transparent, // Transparent background
    foregroundColor: Colors.white, // Text color
    elevation: 0, // No shadow
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Padding
    minimumSize: const Size(113, 36), // Button size
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18.0), // Rounded corners
      side: BorderSide(
        color: Colors.white.withOpacity(0.62), // Border color and opacity
        width: 1.0, // Border width
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
