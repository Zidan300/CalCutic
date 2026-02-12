import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:financial_calculator/widgets/app_drawer.dart';
import 'package:financial_calculator/providers/theme_provider.dart';
import 'package:financial_calculator/utils/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Get.put(ThemeProvider());

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            // The final logo is now integrated.
            const CircleAvatar(
              backgroundImage: AssetImage('assets/images/calcutic.png'),
              radius: 18,
              backgroundColor: Colors.transparent,
            ),
            const SizedBox(width: 12),
            const Text('CalCutic'),
          ],
        ),
        elevation: 1,
        actions: [
          Obx(
            () => IconButton(
              icon: Icon(
                themeProvider.isDarkMode ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
              ),
              splashRadius: 24,
              tooltip: 'Toggle Theme',
              onPressed: () => themeProvider.toggleTheme(),
            ),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              _buildWelcomeCard(),
              const SizedBox(height: 32),
              _buildFeatureGrid(context),
              const SizedBox(height: 32),
              _buildQuickAccessSection(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(AppConstants.primaryColor),
            const Color(AppConstants.primaryColor).withOpacity(0.7),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(AppConstants.primaryColor).withOpacity(0.3),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.calculate_rounded, color: Colors.white, size: 36),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome to CalCutic',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Your All-in-One Calculator',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureGrid(BuildContext context) {
    final features = [
      {'icon': Icons.science_outlined, 'title': 'Scientific', 'route': '/scientific'},
      {'icon': Icons.trending_up_outlined, 'title': 'Interest', 'route': '/simple_interest'},
      {'icon': Icons.receipt_long_outlined, 'title': 'GST', 'route': '/gst'},
      {'icon': Icons.local_offer_outlined, 'title': 'Discount', 'route': '/discount'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Access',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.2,
          ),
          itemCount: features.length,
          itemBuilder: (context, index) {
            final feature = features[index];
            return _buildFeatureTile(
              icon: feature['icon'] as IconData,
              title: feature['title'] as String,
              route: feature['route'] as String,
            );
          },
        ),
      ],
    );
  }

  Widget _buildFeatureTile({
    required IconData icon,
    required String title,
    required String route,
  }) {
    return InkWell(
      onTap: () => Get.toNamed(route),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(Get.context!).cardColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 36, color: const Color(AppConstants.primaryColor)),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAccessSection() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'All Calculators',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        Text(
          'Tap the menu icon at the top-left to access all 10+ calculators, including EMI, Savings Goal, Inflation, Profit/Loss, and more.',
          style: TextStyle(fontSize: 14, color: Colors.grey, height: 1.5),
        ),
      ],
    );
  }
}
