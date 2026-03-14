import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:financial_calculator/utils/constants.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(AppConstants.primaryColor),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'CalCutic',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
            _buildDrawerItem(
              icon: Icons.home_outlined,
              title: 'Home',
              onTap: () => Get.toNamed('/'),
            ),
            _buildExpansionTile(
              context,
              icon: Icons.calculate_rounded,
              title: 'Calculators',
              children: [
                _buildDrawerItem(
                  icon: Icons.calculate_outlined, // Updated Icon
                  title: 'Calculator', // Renamed from Scientific Calculator
                  onTap: () => Get.toNamed('/calculator'), // Use the new route
                ),
                _buildDrawerItem(
                  icon: Icons.trending_up_outlined,
                  title: 'Simple Interest',
                  onTap: () => Get.toNamed('/simple_interest'),
                ),
                _buildDrawerItem(
                  icon: Icons.show_chart_outlined,
                  title: 'Compound Interest',
                  onTap: () => Get.toNamed('/compound_interest'),
                ),
                _buildDrawerItem(
                  icon: Icons.home_work_outlined,
                  title: 'Loan EMI',
                  onTap: () => Get.toNamed('/loan_emi'),
                ),
              ],
            ),
            _buildExpansionTile(
              context,
              icon: Icons.business_center_rounded,
              title: 'Finance Tools',
              children: [
                _buildDrawerItem(
                  icon: Icons.receipt_long_outlined,
                  title: 'GST Calculator',
                  onTap: () => Get.toNamed('/gst'),
                ),
                _buildDrawerItem(
                  icon: Icons.local_offer_outlined,
                  title: 'Discount Calculator',
                  onTap: () => Get.toNamed('/discount'),
                ),
                _buildDrawerItem(
                  icon: Icons.savings_outlined,
                  title: 'Saving Goal Tracker',
                  onTap: () => Get.toNamed('/savings_goal'),
                ),
                _buildDrawerItem(
                  icon: Icons.insights_outlined,
                  title: 'Inflation Calculator',
                  onTap: () => Get.toNamed('/inflation'),
                ),
                _buildDrawerItem(
                  icon: Icons.monetization_on_outlined,
                  title: 'Profit & Loss Calculator',
                  onTap: () => Get.toNamed('/profit_loss'),
                ),
                _buildDrawerItem(
                  icon: Icons.equalizer_outlined,
                  title: 'Break-even Calculator',
                  onTap: () => Get.toNamed('/break_even'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpansionTile(BuildContext context, {required IconData icon, required String title, required List<Widget> children}) {
    return ExpansionTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
      children: children,
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, size: 22, color: Colors.grey[600]),
      title: Text(title, style: const TextStyle(fontSize: 14)),
      onTap: () {
        Get.back();
        onTap();
      },
      contentPadding: const EdgeInsets.only(left: 40),
    );
  }
}
