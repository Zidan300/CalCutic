import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:financial_calculator/controllers/savings_goal_calculator_provider.dart';
import 'package:financial_calculator/widgets/custom_input_field.dart';
import 'package:financial_calculator/widgets/result_card.dart';

class SavingsGoalScreen extends StatelessWidget {
  const SavingsGoalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SavingsGoalCalculatorProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saving Goal Tracker'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomInputField(
              label: 'Target Amount',
              hint: 'Enter your target amount',
              onChanged: controller.setTargetAmount,
            ),
            const SizedBox(height: 16),
            CustomInputField(
              label: 'Current Amount',
              hint: 'Enter your current amount',
              onChanged: controller.setCurrentAmount,
            ),
            const SizedBox(height: 16),
            CustomInputField(
              label: 'Monthly Contribution',
              hint: 'Enter your monthly contribution',
              onChanged: controller.setMonthlyContribution,
            ),
            const SizedBox(height: 32),
            Obx(() => ResultCard(
                  title: 'Months to Reach Goal',
                  value: controller.months.toString(),
                  icon: Icons.calendar_today_outlined,
                )),
          ],
        ),
      ),
    );
  }
}
