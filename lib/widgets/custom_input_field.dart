import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String label;
  final String hint;
  final Function(String)? onChanged;
  final TextInputType keyboardType;
  final String? initialValue; // Added to handle deprecated 'value'

  const CustomInputField({
    super.key,
    required this.label,
    required this.hint,
    this.onChanged,
    this.keyboardType = TextInputType.number,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      keyboardType: keyboardType,
      onChanged: onChanged,
    );
  }
}
