import 'package:flutter/material.dart';
import 'package:safe_ride_mobile/const/appColors.dart';

import 'buttons.dart';
import 'customFont.dart';

class BottomPopupBar extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String? description;
  final String buttonText;
  final VoidCallback? onPressed;
  final bool isError;

  const BottomPopupBar({
    Key? key,
    required this.imageUrl,
    required this.title,
    this.description,
    required this.buttonText,
    this.onPressed,
    this.isError = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Color backgroundColor = isError ? appColors.kRed1 : appColors.kBlue2;

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: backgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height:50),
          Center(
            child: Image.asset(
              imageUrl,
              width: 150.0,
              height: 150.0,
            ),
          ),
          const SizedBox(height: 40),
          CustomText(text: title, fontSize: 28),
          const SizedBox(height: 8),
          if (description != null) ...[
            const SizedBox(height: 8),
            CustomText(text: description!, fontSize: 20),
          ],
          const SizedBox(height: 50),
          ElevatedButton(
            onPressed: onPressed,
            style: AppButtonsStyle.whiteButtonStyle,
            child: CustomText(
              text: buttonText,
              fontSize: 24,
              color: backgroundColor,
            ),
          ),
        ],
      ),
    );
  }
}
