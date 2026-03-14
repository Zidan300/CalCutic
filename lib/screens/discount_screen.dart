import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:financial_calculator/controllers/discount_calculator_provider.dart';
import 'package:financial_calculator/widgets/custom_input_field.dart';
import 'package:financial_calculator/widgets/result_card.dart';

class DiscountScreen extends StatelessWidget {
  const DiscountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DiscountCalculatorProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Discount Calculator'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomInputField(
              label: 'Original Price',
              hint: 'Enter the original price',
              onChanged: controller.setOriginalPrice,
            ),
            const SizedBox(height: 16),
            CustomInputField(
              label: 'Discount Percentage (%)',
              hint: 'Enter the discount percentage',
              onChanged: controller.setDiscountPercentage,
            ),
            const SizedBox(height: 32),
            Obx(() => ResultCard(
                  title: 'Saved Amount',
                  value: controller.savedAmount.toStringAsFixed(2),
                  icon: Icons.savings_outlined,
                )),
            const SizedBox(height: 16),
            Obx(() => ResultCard(
                  title: 'Final Price',
                  value: controller.finalPrice.toStringAsFixed(2),
                  icon: Icons.shopping_cart_checkout_outlined,
                )),
          ],
        ),
      ),
    );
  }
}
