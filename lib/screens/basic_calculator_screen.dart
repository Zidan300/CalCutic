import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:financial_calculator/providers/calculator_provider.dart';
import 'package:financial_calculator/utils/constants.dart';

enum ButtonType { number, operator, special }

class BasicCalculatorScreen extends StatelessWidget {
  const BasicCalculatorScreen({super.key});

  ButtonType _getButtonType(String label) {
    const Set<String> operators = {'÷', '×', '−', '+', '%'};
    if (operators.contains(label)) return ButtonType.operator;
    if (label == 'C' || label == '⌫' || label == '=') return ButtonType.special;
    return ButtonType.number;
  }

  @override
  Widget build(BuildContext context) {
    // Basic calculator layout - 5 rows, 4 columns
    final List<String> buttonLabels = [
      'C', '⌫', '%', '÷',
      '7', '8', '9', '×',
      '4', '5', '6', '−',
      '1', '2', '3', '+',
      '0', '.', '=',
    ];

    return ChangeNotifierProvider(
      create: (_) => CalculatorProvider(),
      child: Consumer<CalculatorProvider>(
        builder: (context, controller, _) {
          return Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/calcutic.png'),
                    radius: 18,
                    backgroundColor: Colors.transparent,
                  ),
                  const SizedBox(width: 12),
                  const Text('CalCutic'),
                ],
              ),
            ),
            body: SafeArea(
              child: Column(
                children: [
                  // Display Section
                  Expanded(
                    flex: 3,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            controller.expression,
                            style: TextStyle(fontSize: 28, color: Colors.grey[600]),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            controller.result,
                            style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Button Grid - Clean 4x5 layout
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          childAspectRatio: 1.0,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemCount: buttonLabels.length,
                        itemBuilder: (context, index) {
                          final label = buttonLabels[index];
                          VoidCallback onPressed = () => controller.buttonPressed(label);
                          if (label == '=') onPressed = controller.calculate;
                          if (label == 'C') onPressed = controller.clear;
                          if (label == '⌫') onPressed = controller.backspace;

                          return CalculatorButton(
                            label: label,
                            onPressed: onPressed,
                            type: _getButtonType(label),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class CalculatorButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final ButtonType type;

  const CalculatorButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.type,
  });

  @override
  State<CalculatorButton> createState() => _CalculatorButtonState();
}

class _CalculatorButtonState extends State<CalculatorButton> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 100));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTap() {
    _animationController.forward().then((_) => _animationController.reverse());
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    Color buttonColor, shadowColor, textColor;

    switch (widget.type) {
      case ButtonType.operator:
        buttonColor = const Color(AppConstants.primaryColor);
        shadowColor = const Color(AppConstants.primaryColor).withAlpha(179);
        textColor = Colors.white;
        break;
      case ButtonType.special:
        buttonColor = Colors.green.shade600;
        shadowColor = Colors.green.shade900.withAlpha(153);
        if (widget.label == 'C' || widget.label == '⌫') {
          buttonColor = Colors.red.shade500;
          shadowColor = Colors.red.shade800.withAlpha(153);
        }
        textColor = Colors.white;
        break;
      default: // Number
        buttonColor = isDark ? const Color(0xFF373737) : Colors.white;
        shadowColor = isDark ? Colors.black26 : Colors.grey.withAlpha(89);
        textColor = isDark ? Colors.white : Colors.black87;
    }

    return ScaleTransition(
      scale: Tween<double>(begin: 1.0, end: 0.95).animate(_animationController),
      child: GestureDetector(
        onTap: _onTap,
        child: Container(
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: shadowColor,
                offset: const Offset(4, 4),
                blurRadius: 8,
              ),
            ],
          ),
          child: Center(
            child: Text(
              widget.label,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
