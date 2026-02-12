import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:financial_calculator/providers/unit_converter_provider.dart';

class ExpandedUnitConverterWidget extends StatelessWidget {
  const ExpandedUnitConverterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UnitConverterProvider());

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Obx(() => DropdownButtonFormField<String>(
                value: controller.conversionType,
                decoration: const InputDecoration(labelText: 'Conversion Type'),
                items: controller.unitTypes.keys.map((String value) {
                  return DropdownMenuItem<String>(value: value, child: Text(value));
                }).toList(),
                onChanged: controller.setConversionType,
              )),
          const SizedBox(height: 16),
          TextField(
            onChanged: controller.setInputValue,
            decoration: const InputDecoration(labelText: 'From'),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          Obx(() => DropdownButtonFormField<String>(
                value: controller.fromUnit,
                items: controller.unitTypes[controller.conversionType]!.map((String value) {
                  return DropdownMenuItem<String>(value: value, child: Text(value));
                }).toList(),
                onChanged: controller.setFromUnit,
              )),
          const SizedBox(height: 32),
          const Icon(Icons.arrow_downward, size: 40),
          const SizedBox(height: 32),
          TextField(
            controller: TextEditingController(text: controller.result),
            readOnly: true,
            decoration: const InputDecoration(labelText: 'To'),
          ),
          const SizedBox(height: 16),
          Obx(() => DropdownButtonFormField<String>(
                value: controller.toUnit,
                items: controller.unitTypes[controller.conversionType]!.map((String value) {
                  return DropdownMenuItem<String>(value: value, child: Text(value));
                }).toList(),
                onChanged: controller.setToUnit,
              )),
        ],
      ),
    );
  }
}
