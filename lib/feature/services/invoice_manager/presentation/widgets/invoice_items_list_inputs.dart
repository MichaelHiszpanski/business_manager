import 'package:business_manager/core/theme/colors.dart';
import 'package:business_manager/core/tools/constants.dart';
import 'package:business_manager/core/widgets/buttons/custom_floating_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InvoiceItemsListInputs extends StatelessWidget {
  final VoidCallback onSaveData;
  final TextEditingController description;
  final TextEditingController itemPrice;
  final TextEditingController totalItems;

  const InvoiceItemsListInputs({
    super.key,
    required this.onSaveData,
    required this.description,
    required this.itemPrice,
    required this.totalItems,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: description,
          decoration: const InputDecoration(labelText: 'Item description'),
        ),
        TextFormField(
          controller: itemPrice,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Item price'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a price';
            }

            final parsedValue = int.tryParse(value);

            if (parsedValue == null) {
              return 'Invalid number format';
            } else if (parsedValue < 1) {
              return 'Price must be at least 1';
            } else if (parsedValue > 1000000000) {
              return 'Price cannot exceed 1,000,000,000';
            }
          },
        ),
        TextFormField(
          controller: totalItems,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Total Items.'),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a value';
            }
            final intValue = int.tryParse(value);
            if (intValue == null ||
                intValue < 1 ||
                intValue > int.parse(totalItems.text)) {
              return 'Enter a value between 1 and ${totalItems.text}';
            }
            return null;
          },
        ),
        const SizedBox(height: Constants.padding16),
        CustomFloatingButton(
          onPressed: onSaveData,
          buttonText: 'Save',
          backgroundColor: Pallete.gradient3,
        ),
      ],
    );
    ;
  }
}
