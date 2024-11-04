import 'package:business_manager/core/tools/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InvoiceDetailsInputs extends StatelessWidget {
  final TextEditingController invoiceNumber;
  final TextEditingController thankYouMessage;
  final TextEditingController paymentDueDays;

  final VoidCallback onSaveData;

  InvoiceDetailsInputs({
    super.key,
    required this.invoiceNumber,
    required this.thankYouMessage,
    TextEditingController? paymentDueDays,
    required this.onSaveData,
  }) : paymentDueDays = paymentDueDays ?? TextEditingController(text: "30");

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: invoiceNumber,
          decoration: const InputDecoration(labelText: 'Invoice Number'),
        ),
        TextFormField(
          controller: thankYouMessage,
          decoration: const InputDecoration(labelText: 'Greetings Message'),
        ),
        TextFormField(
          controller: paymentDueDays,
          keyboardType: TextInputType.number,
          decoration:
              const InputDecoration(labelText: 'Payment is due (Days).'),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            FilteringTextInputFormatter.allow(
              RegExp(r'^(?:[1-9]?[0-9]?|[1-2][0-9]{2}|3[0-5][0-9]|360)$'),
            ),
          ],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a value';
            }
            final intValue = int.tryParse(value);
            if (intValue == null || intValue < 1 || intValue > 360) {
              return 'Enter a value between 1 and 360';
            }
            return null;
          },
        ),
        ElevatedButton(
          onPressed: onSaveData,
          child: const Text('Save'),
        ),

      ],
    );
  }
}
