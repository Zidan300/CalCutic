import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:financial_calculator/controllers/loan_emi_calculator_provider.dart';
import 'package:financial_calculator/widgets/custom_input_field.dart';
import 'package:financial_calculator/widgets/result_card.dart';

class LoanEmiScreen extends StatelessWidget {
  const LoanEmiScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoanEmiCalculatorProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Loan EMI Calculator'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomInputField(
              label: 'Loan Amount',
              hint: 'Enter the loan amount',
              onChanged: controller.setLoanAmount,
            ),
            const SizedBox(height: 16),
            CustomInputField(
              label: 'Interest Rate (%)',
              hint: 'Enter the interest rate',
              onChanged: controller.setInterestRate,
            ),
            const SizedBox(height: 16),
            CustomInputField(
              label: 'Tenure (Years)',
              hint: 'Enter the tenure in years',
              onChanged: controller.setTenure,
            ),
            const SizedBox(height: 32),
            Obx(() => ResultCard(
                  title: 'EMI',
                  value: controller.emi.toStringAsFixed(2),
                  icon: Icons.payment_outlined,
                )),
            const SizedBox(height: 16),
            Obx(() => ResultCard(
                  title: 'Total Interest',
                  value: controller.totalInterest.toStringAsFixed(2),
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
