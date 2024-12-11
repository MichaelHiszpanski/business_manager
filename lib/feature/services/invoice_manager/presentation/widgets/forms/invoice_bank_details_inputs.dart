import 'package:business_manager/core/theme/colors.dart';
import 'package:business_manager/core/tools/constants.dart';
import 'package:business_manager/core/widgets/buttons/custom_floating_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InvoiceBankDetailsInputs extends StatelessWidget {
  final VoidCallback onSaveData;
  final TextEditingController bankName;
  final TextEditingController sortCode;
  final TextEditingController accountNo;

  const InvoiceBankDetailsInputs({
    super.key,
    required this.onSaveData,
    required this.bankName,
    required this.sortCode,
    required this.accountNo,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: bankName,
          decoration: const InputDecoration(labelText: 'Bank Name'),
        ),
        TextFormField(
          controller: sortCode,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Sort Code'),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
        ),
        TextFormField(
          controller: accountNo,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Account Number'),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
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
