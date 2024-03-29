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
    minimumSize: const Size(260, 50),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25.0),
      side: BorderSide(color: Colors.white, width: 2.0),
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
