import 'package:business_manager/core/helpers/validations_helper.dart';
import 'package:business_manager/core/theme/colors.dart';
import 'package:business_manager/core/tools/constants.dart';
import 'package:business_manager/core/widgets/buttons/custom_floating_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InvoiceBankDetailsInputs extends StatefulWidget {
  final VoidCallback onSaveData;
  final TextEditingController bankName;
  final TextEditingController sortCode;
  final TextEditingController accountNo;

  InvoiceBankDetailsInputs({
    super.key,
    required this.onSaveData,
    required this.bankName,
    required this.sortCode,
    required this.accountNo,
  });

  @override
  State<InvoiceBankDetailsInputs> createState() => _InvoiceBankDetailsInputsState();
}

class _InvoiceBankDetailsInputsState extends State<InvoiceBankDetailsInputs> {
  final _keyForm = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _keyForm,
      child: Column(
        children: [
          TextFormField(
            controller: widget.bankName,
            decoration: const InputDecoration(labelText: 'Bank Name'),
            validator: ValidationsHelper.validateTextField,
          ),
          TextFormField(
            controller: widget.sortCode,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Sort Code'),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            validator: ValidationsHelper.validateTextField,
          ),
          TextFormField(
            controller: widget.accountNo,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Account Number'),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            validator: ValidationsHelper.validateTextField,
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
