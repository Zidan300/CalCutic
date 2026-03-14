import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:financial_calculator/controllers/gst_calculator_provider.dart';
import 'package:financial_calculator/widgets/custom_input_field.dart';
import 'package:financial_calculator/widgets/result_card.dart';

class GstScreen extends StatelessWidget {
  const GstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<GstCalculatorProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('GST Calculator'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomInputField(
              label: 'Amount',
              hint: 'Enter the amount',
              onChanged: controller.setAmount,
            ),
            const SizedBox(height: 16),
            CustomInputField(
              label: 'GST Rate (%)',
              hint: 'Enter the GST percentage',
              onChanged: controller.setRate,
            ),
            const SizedBox(height: 32),
            Obx(() => ResultCard(
                  title: 'GST Amount',
                  value: controller.gstAmount.toStringAsFixed(2),
                  icon: Icons.receipt_long_outlined,
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
