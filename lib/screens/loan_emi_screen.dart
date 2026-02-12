import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:financial_calculator/providers/loan_emi_calculator_provider.dart';
import 'package:financial_calculator/widgets/custom_input_field.dart';
import 'package:financial_calculator/widgets/result_card.dart';

class LoanEmiScreen extends StatelessWidget {
  const LoanEmiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoanEmiCalculatorProvider());

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
              onChanged: controller.setPrincipal,
            ),
            const SizedBox(height: 16),
            CustomInputField(
              label: 'Interest Rate (%)',
              hint: 'Enter the interest rate',
              onChanged: controller.setAnnualRate,
            ),
            const SizedBox(height: 16),
            CustomInputField(
              label: 'Tenure (Years)',
              hint: 'Enter the tenure in years',
              onChanged: controller.setTimeValue,
            ),
            const SizedBox(height: 32),
            Obx(() => ResultCard(
                  title: 'EMI',
                  value: controller.monthlyEMI,
                  icon: Icons.payment_outlined,
                )),
            const SizedBox(height: 16),
            Obx(() => ResultCard(
                  title: 'Total Interest',
                  value: controller.totalInterest,
                  icon: Icons.trending_up_outlined,
                )),
            const SizedBox(height: 16),
            Obx(() => ResultCard(
                  title: 'Total Amount',
                  value: controller.totalPayment,
                  icon: Icons.monetization_on_outlined,
                )),
          ],
        ),
      ),
    );
  }
}
