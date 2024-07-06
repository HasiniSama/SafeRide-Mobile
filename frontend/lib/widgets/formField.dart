import 'package:flutter/material.dart';
import 'customFont.dart';

// Custom widget for combining label and text form field
class LabeledFormField extends StatefulWidget {

  final String labelText;
  final double labelFontSize;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;

  const LabeledFormField({
    Key? key,
    required this.labelText,
    this.labelFontSize = 16,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
  }) : super(key: key);

  @override
  State<LabeledFormField> createState() => _LabeledFormFieldState();
}

class _LabeledFormFieldState extends State<LabeledFormField> {

  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: widget.labelText, fontSize: widget.labelFontSize),
        Container(
          height: 50,
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.symmetric(horizontal: 16),
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
          child: TextFormField(
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            obscureText: widget.obscureText,
            style: const TextStyle(
              color: Colors.blue,
              fontFamily: 'Open Sans',
              fontSize: 14,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              suffixIcon: IconButton(
                icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
