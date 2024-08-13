import 'package:flutter/material.dart';

import '../models/child.dart';

class ChildCard extends StatelessWidget {
  final Child? child;
  final String? status;
  final String navigator;
  final IconData icon;

  const ChildCard({
    Key? key,
    required this.child,
    this.status,
    required this.navigator,
    required this.icon
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, navigator, arguments: child);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.grey.shade300, width: 1.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              size: 36.0,
              color: Colors.blueAccent,
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                  (child?.name ?? 'Add a Child'),
                  style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  if (status != null && status!.isNotEmpty) ...[
                    const SizedBox(height: 4.0),
                    Text(
                      status!,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
              size: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
