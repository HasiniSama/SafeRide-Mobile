import 'package:flutter/material.dart';
import 'package:safe_ride_mobile/const/appColors.dart';

class ProfileCard extends StatelessWidget {
  final String name;
  final String email;

  const ProfileCard({super.key, required this.name, required this.email});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [appColors.kBlueGreenGra1, appColors.kBlueGreenGra2],
        ),
        borderRadius: const BorderRadius.only(topRight: Radius.circular(8.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      // width: 286,
      alignment: Alignment.topLeft,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 4.0, // Adjust the border width as needed
              ),
            ),
            child: const CircleAvatar(
              radius: 50.0, // Adjust the size as needed
              backgroundImage: AssetImage(
                  'assets/profile_image.jpg'), // Provide your image asset path
            ),
          ),
          const SizedBox(width: 16.0), // Add spacing between the image and text
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                    fontSize: 22.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5.0), // Add spacing between name and email
              Text(
                email,
                style: const TextStyle(
                    fontSize: 14.0, color:
                    Colors.white,
                    fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ProfileEditCard extends StatelessWidget {
  final String url;
  final bool isEditable;

  const ProfileEditCard({
    super.key,
    required this.url,
    required this.isEditable
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: const Alignment(1.2, 1.2),
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              width: 4.0, // Adjust the border width as needed
            ),
          ),
          child: CircleAvatar(
            radius: 50.0, // Adjust the size as needed
            backgroundImage: AssetImage(url), // Provide your image asset path
          ),
        ),
        if (isEditable)
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: Colors.blue,
                width: 2.0, // Adjust the border width as needed
              ),
            ),
            padding: const EdgeInsets.all(4.0),
            child: const Icon(
              Icons.edit,
              color: Colors.blue, // Color of the edit icon
            ),
          ),
      ],
    );
  }
}

class BusProfileCard extends StatelessWidget {
  final String url;

  const BusProfileCard({
    super.key,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: const Alignment(1.2, 1.2),
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              width: 4.0, // Adjust the border width as needed
            ),
          ),
          child: CircleAvatar(
            radius: 65.0, // Adjust the size as needed
            backgroundImage: AssetImage(url), // Provide your image asset path
          ),
        ),
      ],
    );
  }
}
