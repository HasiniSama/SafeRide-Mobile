import 'package:flutter/material.dart';
import 'package:safe_ride_mobile/const/appColors.dart';

class FileUploadFormField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final double maxWidth;
  final double height;

  const FileUploadFormField({
    Key? key,
    required this.labelText,
    required this.controller,
    this.maxWidth = 260,
    this.height = 200,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: maxWidth,
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.cloud_upload,
            size: 40,
            color: appColors.kBlue2,
          ),
          const SizedBox(height: 8),
          Text(
            labelText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: appColors.kBlue2,
              fontFamily: 'Open Sans',
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Max file size: 50MB',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontFamily: 'Open Sans',
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
