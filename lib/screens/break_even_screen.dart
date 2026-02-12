import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:financial_calculator/providers/break_even_calculator_provider.dart';
import 'package:financial_calculator/widgets/custom_input_field.dart';
import 'package:financial_calculator/widgets/result_card.dart';

class BreakEvenScreen extends StatelessWidget {
  const BreakEvenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BreakEvenCalculatorProvider());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Break-even Calculator'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomInputField(
              label: 'Fixed Costs',
              hint: 'Enter the total fixed costs',
              onChanged: controller.setFixedCosts,
            ),
            const SizedBox(height: 16),
            CustomInputField(
              label: 'Variable Cost Per Unit',
              hint: 'Enter the variable cost per unit',
              onChanged: controller.setVariableCostPerUnit,
            ),
            const SizedBox(height: 16),
            CustomInputField(
              label: 'Selling Price Per Unit',
              hint: 'Enter the selling price per unit',
              onChanged: controller.setSellingPricePerUnit,
            ),
            const SizedBox(height: 32),
            Obx(() => ResultCard(
                  title: 'Break-even Units',
                  value: controller.breakEvenUnits.toStringAsFixed(2),
                  icon: Icons.equalizer_outlined,
                )),
          ],
        ),
      ),
    );
  }
}
