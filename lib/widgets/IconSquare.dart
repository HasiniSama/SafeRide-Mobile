import 'package:flutter/material.dart';
import 'package:safe_ride_mobile/const/appColors.dart';

class IconSquare extends StatelessWidget {
  final String navigator;
  final Icon icon;
  final String name;

  const IconSquare(
      {super.key,
      required this.navigator,
      required this.icon,
      required this.name});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => ProfileDetailPage(),
        // ));
      },
      child: Container(
        width: 100.0,
        height: 100.0,
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              appColors.kBlueGra1,
              appColors.kBlueGra2,
              appColors.kBlueGra1,
            ],
            stops: [0.0774, 1.0195, 1.0195],
            // Figma stops
            transform: GradientRotation(214.48),
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon.icon,
              size: 40.0,
              color: Colors.white,
            ),
            const SizedBox(height: 5.0),
            Center(
              child: Center(
                  child: Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
