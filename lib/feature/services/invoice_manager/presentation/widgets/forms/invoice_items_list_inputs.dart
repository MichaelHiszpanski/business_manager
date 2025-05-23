import 'package:business_manager/core/helpers/validations_helper.dart';
import 'package:business_manager/core/theme/colors.dart';
import 'package:business_manager/core/tools/constants.dart';
import 'package:business_manager/core/widgets/buttons/custom_floating_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InvoiceItemsListInputs extends StatefulWidget {
  final VoidCallback onSaveData;
  final TextEditingController description;
  final TextEditingController itemPrice;
  final TextEditingController totalItems;

 InvoiceItemsListInputs({
    super.key,
    required this.onSaveData,
    required this.description,
    required this.itemPrice,
    required this.totalItems,
  });

  @override
  State<InvoiceItemsListInputs> createState() => _InvoiceItemsListInputsState();
}

class _InvoiceItemsListInputsState extends State<InvoiceItemsListInputs> {
  final _keyForm = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _keyForm,
      child: Column(
        children: [
          TextFormField(
            controller: widget.description,
            decoration: const InputDecoration(labelText: 'Item description'),
            validator: ValidationsHelper.validateTextField,
          ),
          TextFormField(
            controller: widget.itemPrice,
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
              return null;
            },

          ),
          TextFormField(
            controller: widget.totalItems,
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
                  intValue > int.parse(widget.totalItems.text)) {
                return 'Enter a value between 1 and ${widget.totalItems.text}';
              }
              return null;
            },

          ),
          const SizedBox(height: Constants.padding16),
          CustomFloatingButton(
            onPressed: () {
              if (_keyForm.currentState!.validate()) {
                widget.onSaveData();
              }
            },
            buttonText: 'Save',
            backgroundColor: Pallete.gradient3,
          ),
        ],
      ),
    );
    ;
  }
}
