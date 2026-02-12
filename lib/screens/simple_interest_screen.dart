import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:financial_calculator/providers/simple_interest_calculator_provider.dart';
import 'package:financial_calculator/widgets/custom_input_field.dart';
import 'package:financial_calculator/widgets/result_card.dart';

class SimpleInterestScreen extends StatelessWidget {
  const SimpleInterestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SimpleInterestCalculatorProvider());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Interest Calculator'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomInputField(
              label: 'Principal Amount',
              hint: 'Enter the principal amount',
              onChanged: controller.setPrincipal,
            ),
            const SizedBox(height: 16),
            CustomInputField(
              label: 'Rate of Interest (%)',
              hint: 'Enter the rate of interest',
              onChanged: controller.setRate,
            ),
            const SizedBox(height: 16),
            CustomInputField(
              label: 'Time (Years)',
              hint: 'Enter the time in years',
              onChanged: controller.setTime,
            ),
            const SizedBox(height: 32),
            Obx(() => ResultCard(
                  title: 'Interest',
                  value: controller.interest.toStringAsFixed(2),
                  icon: Icons.trending_up_outlined,
                )),
            const SizedBox(height: 16),
            Obx(() => ResultCard(
                  title: 'Total Amount',
                  value: controller.totalAmount.toStringAsFixed(2),
                  icon: Icons.monetization_on_outlined,
                )),
          ],
        ),
      ),
    );
  }
}
