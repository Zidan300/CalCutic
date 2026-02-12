// lib/widgets/dropdown_field.dart

import 'package:flutter/material.dart';
import 'package:financial_calculator/utils/constants.dart';

class DropdownField extends StatelessWidget {
  final String label;
  final String? value;
  final List<DropdownMenuItem<String>> items;
  final void Function(String?)? onChanged;
  final String hint;

  const DropdownField({
    super.key,
    required this.label,
    this.value,
    required this.items,
    this.onChanged,
    this.hint = 'Select an option',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: AppConstants.sm),
        DropdownButtonFormField<String>(
          initialValue: value,
          items: items,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hint,
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppConstants.md,
              vertical: AppConstants.md,
            ),
          ),
        ),
      ],
    );
  }
}
