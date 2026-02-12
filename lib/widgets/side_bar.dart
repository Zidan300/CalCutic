
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Calculator Suite',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ExpansionTile(
            leading: const Icon(Icons.calculate),
            title: const Text('Calculators'),
            children: [
              _buildDrawerItem(
                icon: Icons.science,
                title: 'Scientific Calculator',
                onTap: () => Get.toNamed('/scientific'),
              ),
              _buildDrawerItem(
                icon: Icons.trending_up,
                title: 'Simple Interest',
                onTap: () => Get.toNamed('/simple_interest'),
              ),
              _buildDrawerItem(
                icon: Icons.show_chart,
                title: 'Compound Interest',
                onTap: () => Get.toNamed('/compound_interest'),
              ),
              _buildDrawerItem(
                icon: Icons.home,
                title: 'Loan EMI',
                onTap: () => Get.toNamed('/loan_emi'),
              ),
            ],
          ),
          ExpansionTile(
            leading: const Icon(Icons.business_center),
            title: const Text('Finance Tools'),
            children: [
              _buildDrawerItem(
                icon: Icons.receipt,
                title: 'GST Calculator',
                onTap: () => Get.toNamed('/gst'),
              ),
              _buildDrawerItem(
                icon: Icons.local_offer,
                title: 'Discount Calculator',
                onTap: () => Get.toNamed('/discount'),
              ),
              _buildDrawerItem(
                icon: Icons.savings,
                title: 'Saving Goal Tracker',
                onTap: () => Get.toNamed('/savings_goal'),
              ),
               _buildDrawerItem(
                icon: Icons.insights,
                title: 'Inflation Calculator',
                onTap: () => Get.toNamed('/inflation'),
              ),
              _buildDrawerItem(
                icon: Icons.attach_money,
                title: 'Profit & Loss Calculator',
                onTap: () => Get.toNamed('/profit_loss'),
              ),
              _buildDrawerItem(
                icon: Icons.equalizer,
                title: 'Break-even Calculator',
                onTap: () => Get.toNamed('/break_even'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Get.back(); // Close drawer
        onTap();
      },
    );
  }
}
