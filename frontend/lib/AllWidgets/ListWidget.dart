import 'package:flutter/material.dart';

class ListWidget extends StatelessWidget {
  final String image;
  final String name;
  final String status;

  const ListWidget({
    required this.image,
    required this.name,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(image),
      ),
      title: Text(name),
      subtitle: Text(status),
      // Add more ListTile customization as needed
    );
  }
}