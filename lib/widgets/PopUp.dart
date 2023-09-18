import 'package:flutter/material.dart';
import 'package:safe_ride_mobile/const/appColors.dart';
import 'package:safe_ride_mobile/widgets/buttons.dart';

class BottomPopupBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.rectangle,
        color: appColors.kBlue2Transparent,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50.0),
          topRight: Radius.circular(50.0),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/location1.png',
              width: 100.0,
              height: 100.0,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Title Text',
            style: TextStyle(
              fontSize: 28,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Description Text',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Add your button's functionality here
            },
            style: AppButtonsStyle.popupButtonStyle,
            child: const Text('Click Me', style: TextStyle(color: appColors.kBlue2, fontSize: 24)),
          ),
        ],
      ),
    );
  }
}
// BottomPopupBar(),


// ElevatedButton(
// onPressed: () {
// // Show the bottom popup bar when the button is pressed
// showModalBottomSheet(
// context: context,
// builder: (BuildContext context) {
// return BottomPopupBar();
// },
// );
// },
// child: Text('Open Popup'),
// ),