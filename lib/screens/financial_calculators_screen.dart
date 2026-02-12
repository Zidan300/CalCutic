import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:financial_calculator/providers/financial_calculator_provider.dart';
import 'package:financial_calculator/widgets/custom_input_field.dart';
import 'package:financial_calculator/widgets/result_card.dart';
import 'package:financial_calculator/utils/constants.dart';
import 'package:financial_calculator/utils/number_formatter.dart';

class FinancialCalculatorsScreen extends StatelessWidget {
  const FinancialCalculatorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FinancialCalculatorProvider());

    return DefaultTabController(
      length: 5, // Removed Currency Converter
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Financial Tools'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'GST'),
              Tab(text: 'Discount'),
              Tab(text: 'Savings Goal'),
              Tab(text: 'Inflation'),
              Tab(text: 'Profit/Loss'),
              Tab(text: 'Break-even'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildGSTTab(controller),
            _buildDiscountTab(controller),
            _buildSavingsTab(controller),
            _buildInflationTab(controller),
            _buildProfitTab(controller),
            _buildBreakEvenTab(controller),
          ],
        ),
      ),
    );
  }

  Widget _buildGSTTab(FinancialCalculatorProvider controller) {
    final basePriceController = TextEditingController();
    final gstRateController = TextEditingController();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.md),
      child: Column(
        children: [
          CustomInputField(label: 'Base Price', hint: 'Enter base price', controller: basePriceController),
          const SizedBox(height: AppConstants.md),
          CustomInputField(label: 'GST Rate (%)', hint: 'Enter GST rate', controller: gstRateController),
          const SizedBox(height: AppConstants.lg),
          ElevatedButton(
            onPressed: () => controller.calculateGst(basePriceController.text, gstRateController.text),
            child: const Text('Calculate'),
          ),
          const SizedBox(height: AppConstants.lg),
          Obx(() => controller.gstResult.isNotEmpty
              ? Column(
                  children: [
                    ResultCard(title: 'GST Amount', value: NumberFormatter.formatCurrency(controller.gstResult['gstAmount'] ?? 0)),
                    const SizedBox(height: AppConstants.md),
                    ResultCard(title: 'Final Price', value: NumberFormatter.formatCurrency(controller.gstResult['finalPrice'] ?? 0)),
                  ],
                )
              : const SizedBox.shrink()),
        ],
      ),
    );
  }

  Widget _buildDiscountTab(FinancialCalculatorProvider controller) {
    final originalPriceController = TextEditingController();
    final discountPercentController = TextEditingController();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.md),
      child: Column(
        children: [
          CustomInputField(label: 'Original Price', hint: 'Enter original price', controller: originalPriceController),
          const SizedBox(height: AppConstants.md),
          CustomInputField(label: 'Discount (%)', hint: 'Enter discount percentage', controller: discountPercentController),
          const SizedBox(height: AppConstants.lg),
          ElevatedButton(
            onPressed: () => controller.calculateDiscount(originalPriceController.text, discountPercentController.text),
            child: const Text('Calculate'),
          ),
          const SizedBox(height: AppConstants.lg),
          Obx(() => controller.discountResult.isNotEmpty
              ? Column(
                  children: [
                    ResultCard(title: 'Discount Amount', value: NumberFormatter.formatCurrency(controller.discountResult['discountAmount'] ?? 0)),
                    const SizedBox(height: AppConstants.md),
                    ResultCard(title: 'Final Price', value: NumberFormatter.formatCurrency(controller.discountResult['finalPrice'] ?? 0)),
                  ],
                )
              : const SizedBox.shrink()),
        ],
      ),
    );
  }

  Widget _buildSavingsTab(FinancialCalculatorProvider controller) {
    final targetAmountController = TextEditingController();
    final monthlyContributionController = TextEditingController();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.md),
      child: Column(
        children: [
          CustomInputField(label: 'Target Amount', hint: 'Enter target amount', controller: targetAmountController),
          const SizedBox(height: AppConstants.md),
          CustomInputField(label: 'Monthly Contribution', hint: 'Enter monthly contribution', controller: monthlyContributionController),
          const SizedBox(height: AppConstants.lg),
          ElevatedButton(
            onPressed: () => controller.calculateSavingsGoal(targetAmountController.text, monthlyContributionController.text),
            child: const Text('Calculate'),
          ),
          const SizedBox(height: AppConstants.lg),
          Obx(() => controller.savingsResult.isNotEmpty
              ? Column(
                  children: [
                    ResultCard(title: 'Months Required', value: (controller.savingsResult['monthsRequired'] ?? 0).toStringAsFixed(0)),
                    const SizedBox(height: AppConstants.md),
                    ResultCard(title: 'Years Required', value: (controller.savingsResult['yearsRequired'] ?? 0).toStringAsFixed(2)),
                  ],
                )
              : const SizedBox.shrink()),
        ],
      ),
    );
  }

  Widget _buildInflationTab(FinancialCalculatorProvider controller) {
    final presentValueController = TextEditingController();
    final inflationRateController = TextEditingController();
    final yearsController = TextEditingController();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.md),
      child: Column(
        children: [
          CustomInputField(label: 'Present Value', hint: 'Enter present value', controller: presentValueController),
          const SizedBox(height: AppConstants.md),
          CustomInputField(label: 'Inflation Rate (%)', hint: 'Enter inflation rate', controller: inflationRateController),
          const SizedBox(height: AppConstants.md),
          CustomInputField(label: 'Years', hint: 'Enter number of years', controller: yearsController),
          const SizedBox(height: AppConstants.lg),
          ElevatedButton(
            onPressed: () => controller.calculateInflation(presentValueController.text, inflationRateController.text, yearsController.text),
            child: const Text('Calculate'),
          ),
          const SizedBox(height: AppConstants.lg),
          Obx(() => controller.inflationResult.isNotEmpty
              ? Column(
                  children: [
                    ResultCard(title: 'Future Value', value: NumberFormatter.formatCurrency(controller.inflationResult['futureValue'] ?? 0)),
                    const SizedBox(height: AppConstants.md),
                    ResultCard(title: 'Value Eroded', value: NumberFormatter.formatCurrency(controller.inflationResult['valueEroded'] ?? 0)),
                  ],
                )
              : const SizedBox.shrink()),
        ],
      ),
    );
  }

  Widget _buildProfitTab(FinancialCalculatorProvider controller) {
    final costPriceController = TextEditingController();
    final sellingPriceController = TextEditingController();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.md),
      child: Column(
        children: [
          CustomInputField(label: 'Cost Price', hint: 'Enter cost price', controller: costPriceController),
          const SizedBox(height: AppConstants.md),
          CustomInputField(label: 'Selling Price', hint: 'Enter selling price', controller: sellingPriceController),
          const SizedBox(height: AppConstants.lg),
          ElevatedButton(
            onPressed: () => controller.calculateProfitLoss(costPriceController.text, sellingPriceController.text),
            child: const Text('Calculate'),
          ),
          const SizedBox(height: AppConstants.lg),
          Obx(() => controller.profiLossResult.isNotEmpty
              ? Column(
                  children: [
                    ResultCard(title: controller.profiLossResult['type'] == 1 ? 'Profit' : 'Loss', value: NumberFormatter.formatCurrency(controller.profiLossResult['profitLoss']?.abs() ?? 0)),
                    const SizedBox(height: AppConstants.md),
                    ResultCard(title: 'Margin %', value: '${(controller.profiLossResult['profitLossPercent'] ?? 0).toStringAsFixed(2)}%'),
                  ],
                )
              : const SizedBox.shrink()),
        ],
      ),
    );
  }

  Widget _buildBreakEvenTab(FinancialCalculatorProvider controller) {
    final fixedCostsController = TextEditingController();
    final costPerUnitController = TextEditingController();
    final pricePerUnitController = TextEditingController();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.md),
      child: Column(
        children: [
          CustomInputField(label: 'Fixed Costs', hint: 'Enter fixed costs', controller: fixedCostsController),
          const SizedBox(height: AppConstants.md),
          CustomInputField(label: 'Cost Per Unit', hint: 'Enter cost per unit', controller: costPerUnitController),
          const SizedBox(height: AppConstants.md),
          CustomInputField(label: 'Price Per Unit', hint: 'Enter price per unit', controller: pricePerUnitController),
          const SizedBox(height: AppConstants.lg),
          ElevatedButton(
            onPressed: () => controller.calculateBreakEven(fixedCostsController.text, costPerUnitController.text, pricePerUnitController.text),
            child: const Text('Calculate'),
          ),
          const SizedBox(height: AppConstants.lg),
          Obx(() => controller.breakEvenResult.isNotEmpty
              ? Column(
                  children: [
                    ResultCard(title: 'Break-even Units', value: (controller.breakEvenResult['breakEvenUnits'] ?? 0).toStringAsFixed(2)),
                    const SizedBox(height: AppConstants.md),
                    ResultCard(title: 'Break-even Sales', value: NumberFormatter.formatCurrency(controller.breakEvenResult['breakEvenSales'] ?? 0)),
                  ],
                )
              : const SizedBox.shrink()),
        ],
      ),
    );
  }
}
