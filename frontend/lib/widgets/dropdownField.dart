import 'package:flutter/material.dart';
import 'package:safe_ride_mobile/const/appColors.dart';

class CustomDropdownField extends StatelessWidget {
  final String labelText;
  final List<String> items;
  final String selectedItem;
  final ValueChanged<String?> onChanged;

  const CustomDropdownField({
    Key? key,
    required this.labelText,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15.0, top: 8.0),
          child: Text(
            labelText,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Container(
            width: 260.0,
            margin: const EdgeInsets.symmetric(vertical: 5.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: DropdownButtonFormField<String>(
              value: selectedItem.isEmpty ? null : selectedItem,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide.none,
                ),
              ),
              hint: const Text(
                'Select School',
                style: TextStyle(
                  fontSize: 16.0,
                  color: appColors.kBlue2,
                ),
              ),
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: onChanged,
              dropdownColor: Colors.white,
              iconEnabledColor: appColors.kBlue2,
              style: const TextStyle(
                fontSize: 16.0,
                color: appColors.kBlue2,
              ),
              isExpanded: true,
            ),
          ),
        ),
      ],
    );
  }
}
