// lib/screens/emi_calculator_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:financial_calculator/services/emi_calculator_service.dart';
import 'package:financial_calculator/widgets/custom_input_field.dart';
import 'package:financial_calculator/widgets/result_card.dart';
import 'package:financial_calculator/widgets/section_header.dart';
import 'package:financial_calculator/utils/constants.dart';
import 'package:financial_calculator/utils/number_formatter.dart';
import 'package:financial_calculator/utils/validators.dart';

class EMICalculatorScreen extends StatefulWidget {
  const EMICalculatorScreen({super.key});

  @override
  State<EMICalculatorScreen> createState() => _EMICalculatorScreenState();
}

class _EMICalculatorScreenState extends State<EMICalculatorScreen> {
  final _service = EMICalculatorService();

  final _principal = TextEditingController();
  final _rate = TextEditingController();
  final _tenure = TextEditingController();
  final _results = Rxn<Map<String, dynamic>>();
  final _showSchedule = false.obs;

  void _calculateEMI() {
    if (InputValidator.isValidPositiveNonZero(_principal.text) &&
        InputValidator.isValidPositiveNumber(_rate.text) &&
        InputValidator.isValidPositiveNonZero(_tenure.text)) {
      final result = _service.calculateEMI(
        principal: double.parse(_principal.text),
        annualRate: double.parse(_rate.text),
        tenureMonths: double.parse(_tenure.text),
      );

      if (result.success) {
        _results.value = result.data;
      } else {
        Get.snackbar('Error', result.error ?? 'Calculation failed');
      }
    } else {
      Get.snackbar('Error', 'Please enter valid values');
    }
  }

  @override
  void dispose() {
    _principal.dispose();
    _rate.dispose();
    _tenure.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EMI Calculator'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
              title: 'Loan EMI Calculator',
              subtitle: 'Calculate monthly installment for your loan',
              icon: Icons.home_work,
            ),
            const SizedBox(height: AppConstants.lg),
            CustomInputField(
              label: 'Loan Amount (₹)',
              hint: 'Enter loan principal',
              controller: _principal,
              suffix: '₹',
            ),
            const SizedBox(height: AppConstants.md),
            CustomInputField(
              label: 'Annual Interest Rate (%)',
              hint: 'Enter interest rate per annum',
              controller: _rate,
              suffix: '%',
            ),
            const SizedBox(height: AppConstants.md),
            CustomInputField(
              label: 'Loan Tenure (Months)',
              hint: 'Enter loan duration in months',
              controller: _tenure,
              suffix: 'Months',
            ),
            const SizedBox(height: AppConstants.lg),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _calculateEMI,
                child: const Text('Calculate EMI'),
              ),
            ),
            const SizedBox(height: AppConstants.lg),
            Obx(
              () => _results.value != null
                  ? Column(
                      children: [
                        ResultCard(
                          title: 'Monthly EMI',
                          value: NumberFormatter.formatCurrency(
                            _results.value!['emi'] ?? 0,
                          ),
                          icon: Icons.calendar_month,
                        ),
                        const SizedBox(height: AppConstants.md),
                        ResultCard(
                          title: 'Total Interest Payable',
                          value: NumberFormatter.formatCurrency(
                            _results.value!['totalInterest'] ?? 0,
                          ),
                          icon: Icons.trending_up,
                        ),
                        const SizedBox(height: AppConstants.md),
                        ResultCard(
                          title: 'Total Payment',
                          value: NumberFormatter.formatCurrency(
                            _results.value!['totalPayment'] ?? 0,
                          ),
                          icon: Icons.account_balance_wallet,
                        ),
                        const SizedBox(height: AppConstants.lg),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () => _showSchedule.value = !_showSchedule.value,
                            icon: const Icon(Icons.schedule),
                            label: Obx(
                              () => Text(
                                _showSchedule.value
                                    ? 'Hide Schedule'
                                    : 'Show Amortization Schedule',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: AppConstants.lg),
                        Obx(
                          () => _showSchedule.value
                              ? _buildAmortizationSchedule()
                              : const SizedBox.shrink(),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAmortizationSchedule() {
    final schedule = _results.value!['amortizationSchedule'] as List<dynamic>;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Amortization Schedule',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppConstants.md),
        SizedBox(
          height: 300,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Month')),
                  DataColumn(label: Text('EMI')),
                  DataColumn(label: Text('Principal')),
                  DataColumn(label: Text('Interest')),
                  DataColumn(label: Text('Balance')),
                ],
                rows: schedule
                    .take(12) // Show first 12 months
                    .map((item) => DataRow(cells: [
                          DataCell(Text(item['month'].toString())),
                          DataCell(Text(
                              NumberFormatter.formatCurrency(item['emi']))),
                          DataCell(Text(NumberFormatter.formatCurrency(
                              item['principal']))),
                          DataCell(Text(
                              NumberFormatter.formatCurrency(item['interest']))),
                          DataCell(Text(
                              NumberFormatter.formatCurrency(item['balance']))),
                        ]))
                    .toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
