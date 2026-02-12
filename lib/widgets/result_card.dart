// lib/widgets/result_card.dart

import 'package:flutter/material.dart';
import 'package:financial_calculator/utils/constants.dart';

class ResultCard extends StatelessWidget {
  final String title;
  final String value;
  final String? subtitle;
  final Color? backgroundColor;
  final IconData? icon;

  const ResultCard({
    super.key,
    required this.title,
    required this.value,
    this.subtitle,
    this.backgroundColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(AppConstants.md),
      decoration: BoxDecoration(
        color: backgroundColor ??
            (isDark ? const Color(AppConstants.darkSurface) : const Color(0xFFF5F7FA)),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(
          color: isDark ? const Color(0xFF555555) : const Color(0xFFE0E0E0),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Icon(icon, size: 20, color: const Color(AppConstants.primaryColor)),
                const SizedBox(width: AppConstants.sm),
              ],
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: isDark ? const Color(AppConstants.darkText) : Colors.grey,
                        fontSize: 12,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.sm),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: AppConstants.xs),
            Text(
              subtitle!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
            ),
          ],
        ],
      ),
    );
  }
}
