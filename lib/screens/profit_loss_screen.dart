import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:financial_calculator/providers/profit_loss_calculator_provider.dart';
import 'package:financial_calculator/widgets/custom_input_field.dart';
import 'package:financial_calculator/widgets/result_card.dart';

class ProfitLossScreen extends StatelessWidget {
  const ProfitLossScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfitLossCalculatorProvider());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profit & Loss Calculator'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomInputField(
              label: 'Cost Price',
              hint: 'Enter the cost price',
              onChanged: controller.setCostPrice,
            ),
            const SizedBox(height: 16),
            CustomInputField(
              label: 'Selling Price',
              hint: 'Enter the selling price',
              onChanged: controller.setSellingPrice,
            ),
            const SizedBox(height: 32),
            Obx(() => ResultCard(
                  title: controller.isProfit ? 'Profit' : 'Loss',
                  value: controller.profitOrLoss.toStringAsFixed(2),
                  icon: controller.isProfit ? Icons.arrow_upward_outlined : Icons.arrow_downward_outlined,
                )),
          ],
        ),
      ),
    );
  }
}
