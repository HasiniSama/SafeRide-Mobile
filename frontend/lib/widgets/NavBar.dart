import 'package:flutter/material.dart';
import 'package:safe_ride_mobile/const/appColors.dart';
import 'package:safe_ride_mobile/widgets/PopUp.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              appColors.kBlueGreenGra1,
              appColors.kBlueGreenGra2,
            ],
          ),
        ),
      ),
      title: const Text(
        'Welcome!',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 18.0,
        ),
      ),
      leading: Builder(
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Image.asset(
                'assets/menu.png',
                width: 30.0,
                height: 30.0,
              ),
            ),
          );
        },
      ),
      actions: <Widget>[
        Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/parent_profile'),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 4.0,
                  ),
                ),
                child: const CircleAvatar(
                  radius: 15.0,
                  backgroundImage: AssetImage('assets/profile_image.jpg'),
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            IconButton(
              icon: const Icon(
                Icons.notifications,
                size: 30.0,
              ),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return BottomPopupBar(
                      imageUrl: 'assets/location1.png',
                      title: 'Title Text',
                      description: 'Description Text',
                      buttonText: 'Click Me',
                      onPressed: () {
                        Navigator.pop(context); // Close the bottom sheet
                      },
                    );
                  },
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.exit_to_app), // Logout icon
              onPressed: () {
                // Implement logout logic here, e.g., clearing user session
                // Example: Clear user session and navigate to login screen
                Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
              },
            ),
          ],
        ),
      ],
      centerTitle: true,
    );
  }
}
