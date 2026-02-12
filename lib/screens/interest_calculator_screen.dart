// lib/screens/interest_calculator_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:financial_calculator/services/interest_calculator_service.dart';
import 'package:financial_calculator/widgets/custom_input_field.dart';
import 'package:financial_calculator/widgets/result_card.dart';
import 'package:financial_calculator/widgets/dropdown_field.dart';
import 'package:financial_calculator/widgets/section_header.dart';
import 'package:financial_calculator/utils/constants.dart';
import 'package:financial_calculator/utils/number_formatter.dart';
import 'package:financial_calculator/utils/validators.dart';

class InterestCalculatorScreen extends StatefulWidget {
  const InterestCalculatorScreen({super.key});

  @override
  State<InterestCalculatorScreen> createState() => _InterestCalculatorScreenState();
}

class _InterestCalculatorScreenState extends State<InterestCalculatorScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _service = InterestCalculatorService();

  // Simple Interest
  final _principalSI = TextEditingController();
  final _rateSI = TextEditingController();
  final _timeSI = TextEditingController();
  final _resultsSI = Rxn<Map<String, double>>();

  // Compound Interest
  final _principalCI = TextEditingController();
  final _rateCI = TextEditingController();
  final _timeCI = TextEditingController();
  final _periodCI = Rxn<CompoundingPeriod>();
  final _resultsCI = Rxn<Map<String, dynamic>>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _principalSI.dispose();
    _rateSI.dispose();
    _timeSI.dispose();
    _principalCI.dispose();
    _rateCI.dispose();
    _timeCI.dispose();
    super.dispose();
  }

  void _calculateSimpleInterest() {
    if (InputValidator.isValidPositiveNonZero(_principalSI.text) &&
        InputValidator.isValidPositiveNumber(_rateSI.text) &&
        InputValidator.isValidPositiveNonZero(_timeSI.text)) {
      final result = _service.calculateSimpleInterest(
        principal: double.parse(_principalSI.text),
        rate: double.parse(_rateSI.text),
        time: double.parse(_timeSI.text),
      );

      if (result.success) {
        _resultsSI.value = result.data;
      } else {
        Get.snackbar('Error', result.error ?? 'Calculation failed');
      }
    } else {
      Get.snackbar('Error', 'Please enter valid values');
    }
  }

  void _calculateCompoundInterest() {
    if (InputValidator.isValidPositiveNonZero(_principalCI.text) &&
        InputValidator.isValidPositiveNumber(_rateCI.text) &&
        InputValidator.isValidPositiveNonZero(_timeCI.text) &&
        _periodCI.value != null) {
      final result = _service.calculateCompoundInterest(
        principal: double.parse(_principalCI.text),
        rate: double.parse(_rateCI.text),
        time: double.parse(_timeCI.text),
        period: _periodCI.value!,
      );

      if (result.success) {
        _resultsCI.value = result.data;
      } else {
        Get.snackbar('Error', result.error ?? 'Calculation failed');
      }
    } else {
      Get.snackbar('Error', 'Please enter valid values');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interest Calculator'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Simple Interest'),
            Tab(text: 'Compound Interest'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Simple Interest Tab
          _buildSimpleInterestTab(context),
          // Compound Interest Tab
          _buildCompoundInterestTab(context),
        ],
      ),
    );
  }

  Widget _buildSimpleInterestTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: 'Simple Interest',
            subtitle: 'Calculate interest without compounding',
            icon: Icons.trending_up,
          ),
          const SizedBox(height: AppConstants.lg),
          CustomInputField(
            label: 'Principal Amount (₹)',
            hint: 'Enter principal amount',
            controller: _principalSI,
            suffix: '₹',
          ),
          const SizedBox(height: AppConstants.md),
          CustomInputField(
            label: 'Annual Rate (%)',
            hint: 'Enter interest rate',
            controller: _rateSI,
            suffix: '%',
          ),
          const SizedBox(height: AppConstants.md),
          CustomInputField(
            label: 'Time Period (Years)',
            hint: 'Enter time period',
            controller: _timeSI,
            suffix: 'Years',
          ),
          const SizedBox(height: AppConstants.lg),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _calculateSimpleInterest,
              child: const Text('Calculate'),
            ),
          ),
          const SizedBox(height: AppConstants.lg),
          Obx(
            () => _resultsSI.value != null
                ? Column(
                    children: [
                      ResultCard(
                        title: 'Simple Interest',
                        value: NumberFormatter.formatCurrency(
                          _resultsSI.value!['simpleInterest'] ?? 0,
                        ),
                        icon: Icons.attach_money,
                      ),
                      const SizedBox(height: AppConstants.md),
                      ResultCard(
                        title: 'Total Amount',
                        value: NumberFormatter.formatCurrency(
                          _resultsSI.value!['totalAmount'] ?? 0,
                        ),
                        icon: Icons.account_balance_wallet,
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildCompoundInterestTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: 'Compound Interest',
            subtitle: 'Calculate interest with compounding',
            icon: Icons.trending_up,
          ),
          const SizedBox(height: AppConstants.lg),
          CustomInputField(
            label: 'Principal Amount (₹)',
            hint: 'Enter principal amount',
            controller: _principalCI,
            suffix: '₹',
          ),
          const SizedBox(height: AppConstants.md),
          CustomInputField(
            label: 'Annual Rate (%)',
            hint: 'Enter interest rate',
            controller: _rateCI,
            suffix: '%',
          ),
          const SizedBox(height: AppConstants.md),
          CustomInputField(
            label: 'Time Period (Years)',
            hint: 'Enter time period',
            controller: _timeCI,
            suffix: 'Years',
          ),
          const SizedBox(height: AppConstants.md),
          DropdownField(
            label: 'Compounding Period',
            value: _periodCI.value?.name,
            items: CompoundingPeriod.values
                .map(
                  (period) => DropdownMenuItem(
                    value: period.name,
                    child: Text(period.display),
                  ),
                )
                .toList(),
            onChanged: (value) {
              _periodCI.value = CompoundingPeriod.values
                  .firstWhere((p) => p.name == value, orElse: () => CompoundingPeriod.monthly);
            },
          ),
          const SizedBox(height: AppConstants.lg),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _calculateCompoundInterest,
              child: const Text('Calculate'),
            ),
          ),
          const SizedBox(height: AppConstants.lg),
          Obx(
            () => _resultsCI.value != null
                ? Column(
                    children: [
                      ResultCard(
                        title: 'Compound Interest',
                        value: NumberFormatter.formatCurrency(
                          _resultsCI.value!['compoundInterest'] ?? 0,
                        ),
                        icon: Icons.attach_money,
                      ),
                      const SizedBox(height: AppConstants.md),
                      ResultCard(
                        title: 'Total Amount',
                        value: NumberFormatter.formatCurrency(
                          _resultsCI.value!['totalAmount'] ?? 0,
                        ),
                        icon: Icons.account_balance_wallet,
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
