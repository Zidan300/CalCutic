import 'package:flutter/material.dart';
import 'package:financial_calculator/utils/constants.dart';

class ResultCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData? icon;

  const ResultCard({
    super.key,
    required this.title,
    required this.value,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppConstants.md), // Using AppConstants.md
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.md), // Using AppConstants.md
        child: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, size: 30, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: AppConstants.md), // Using AppConstants.md
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
