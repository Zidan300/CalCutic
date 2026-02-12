import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:financial_calculator/providers/discount_calculator_provider.dart';
import 'package:financial_calculator/widgets/custom_input_field.dart';
import 'package:financial_calculator/widgets/result_card.dart';

class DiscountScreen extends StatelessWidget {
  const DiscountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DiscountCalculatorProvider());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Discount Calculator'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        children: [
          _buildInputSection(controller, context),
          const SizedBox(height: 32),
          _buildResultSection(controller, context),
        ],
      ),
    );
  }

  // Private widget for the input section to improve readability.
  Widget _buildInputSection(DiscountCalculatorProvider controller, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Enter Calculation Details',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
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
      ],
    );
  }

  // Private widget for the results section.
  Widget _buildResultSection(DiscountCalculatorProvider controller, BuildContext context) {
    return Obx(() {
      // Conditionally render the results to provide a better user experience.
      if (controller.originalPrice <= 0) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.only(top: 40),
            child: Text(
              'Results will be displayed here.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
        );
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Your Savings',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ResultCard(
            title: 'Saved Amount',
            value: controller.savedAmount.toStringAsFixed(2),
            icon: Icons.savings_outlined,
          ),
          const SizedBox(height: 16),
          ResultCard(
            title: 'Final Price',
            value: controller.finalPrice.toStringAsFixed(2),
            icon: Icons.shopping_cart_checkout_outlined,
          ),
        ],
      );
    });
  }
}
