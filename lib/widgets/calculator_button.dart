import 'package:flutter/material.dart';
import 'package:financial_calculator/utils/constants.dart';

class CalculatorButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isOperator;
  final bool isSpecial;

  const CalculatorButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isOperator = false,
    this.isSpecial = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    Color buttonColor = isDark ? const Color(0xFF2D2D2D) : Colors.grey[200]!;
    Color textColor = isDark ? Colors.white : Colors.black;

    if (isOperator) {
      buttonColor = const Color(AppConstants.primaryColor);
      textColor = Colors.white;
    } else if (isSpecial) {
      buttonColor = isDark ? const Color(0xFF404040) : Colors.grey[300]!;
    }

    return Material(
      color: buttonColor,
      borderRadius: BorderRadius.circular(AppConstants.radiusMd),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        child: Center(
          child: Text(
            label,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: textColor),
          ),
        ),
      ),
    );
  }
}
