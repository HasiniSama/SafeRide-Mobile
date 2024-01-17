import 'package:flutter/material.dart';

class List extends StatelessWidget {
  final String image;
  final String name;
  final String status;

  const List(
      {super.key,
      required this.image,
      required this.name,
      required this.status});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          // Navigator.of(context).push(MaterialPageRoute(
          //   builder: (context) => ProfileDetailPage(),
          // ));
        },
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 4.0,
                ),
              ),
              child: CircleAvatar(
                radius: 15.0,
                backgroundImage: AssetImage(image),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              name,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const Spacer(),
            Text(
              status,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ));
  }
}
