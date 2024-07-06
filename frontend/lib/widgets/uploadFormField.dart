import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:safe_ride_mobile/const/appColors.dart';

class FileUploadFormField extends StatefulWidget {
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
  State<FileUploadFormField> createState() => _FileUploadFormFieldState();
}

class _FileUploadFormFieldState extends State<FileUploadFormField> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {

        FilePickerResult? result = await FilePicker.platform.pickFiles();

        if (result != null) {
          widget.controller.text = result.files.single.path!;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('File selected: ${result.files.single.name}')),
          );
        } else {
          // User canceled the picker
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('File selection canceled')),
          );
        }
      },
      child: Container(
        width: widget.maxWidth,
        height: widget.height,
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
              widget.labelText,
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
            const SizedBox(height: 4),
            if (widget.controller.text.isNotEmpty)
              Text(
                'File: ${widget.controller.text.split('/').last}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.blue,
                  fontFamily: 'Open Sans',
                  fontSize: 12,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
