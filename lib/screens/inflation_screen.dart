import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:financial_calculator/providers/inflation_calculator_provider.dart';
import 'package:financial_calculator/widgets/custom_input_field.dart';
import 'package:financial_calculator/widgets/result_card.dart';

class InflationScreen extends StatelessWidget {
  const InflationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(InflationCalculatorProvider());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inflation Calculator'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomInputField(
              label: 'Initial Amount',
              hint: 'Enter the initial amount',
              onChanged: controller.setInitialAmount,
            ),
            const SizedBox(height: 16),
            CustomInputField(
              label: 'Inflation Rate (%)',
              hint: 'Enter the inflation rate',
              onChanged: controller.setInflationRate,
            ),
            const SizedBox(height: 16),
            CustomInputField(
              label: 'Years',
              hint: 'Enter the number of years',
              onChanged: controller.setYears,
            ),
            const SizedBox(height: 32),
            Obx(() => ResultCard(
                  title: 'Future Value',
                  value: controller.futureValue.toStringAsFixed(2),
                  icon: Icons.insights_outlined,
                )),
          ],
        ),
      ),
    );
  }
}
