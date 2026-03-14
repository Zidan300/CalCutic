import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:financial_calculator/controllers/calculator_provider.dart';
import 'package:intl/intl.dart'; // For date formatting

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the instance of CalculatorProvider
    final controller = Get.find<CalculatorProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculation History'),
        actions: [
          Obx(
            () => Visibility(
              visible: controller.history.isNotEmpty, // Only show if history is not empty
              child: IconButton(
                icon: const Icon(Icons.delete_sweep_outlined),
                onPressed: () {
                  // Show a confirmation dialog before clearing history
                  Get.defaultDialog(
                    title: "Clear History",
                    middleText: "Are you sure you want to clear all calculation history?",
                    textConfirm: "Clear",
                    textCancel: "Cancel",
                    confirmTextColor: Colors.white,
                    buttonColor: Colors.red,
                    onConfirm: () {
                      controller.clearHistory();
                      Get.back(); // Close the dialog
                    },
                    onCancel: () {
                      Get.back(); // Close the dialog
                    },
                  );
                },
                tooltip: 'Clear History',
              ),
            ),
          ),
        ],
      ),
      body: Obx(
        () {
          if (controller.history.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.history, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No history yet!',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  Text(
                    'Perform some calculations to see your history here.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: controller.history.length,
            itemBuilder: (context, index) {
              final item = controller.history[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 4.0),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.expression,
                        style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '= ${item.result}',
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          DateFormat('MMM dd, yyyy - hh:mm a').format(item.timestamp),
                          style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
