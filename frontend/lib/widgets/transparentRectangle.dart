import 'package:flutter/material.dart';

class TransparentRectangle extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const TransparentRectangle({super.key,
    this.width = 325.0,
    this.height = 445.0,
    this.borderRadius = 25.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: Colors.white.withOpacity(0.36),
          width: 1.0,
        ),
        color: Colors.white.withOpacity(0.17),
      ),
    );
  }
}
