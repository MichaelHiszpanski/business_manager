import 'package:business_manager/core/theme/colors.dart';
import 'package:business_manager/core/tools/constants.dart';
import 'package:business_manager/core/widgets/buttons/custom_floating_button.dart';
import 'package:business_manager/core/widgets/date_picker/date_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InvoiceDetailsInputs extends StatefulWidget {
  final TextEditingController invoiceNumber;
  final TextEditingController thankYouMessage;
  final TextEditingController paymentDueDays;
  final VoidCallback onSaveData;
  final Function(bool) onFormValidated;
  final Function(DateTime) onDateSelected;

  InvoiceDetailsInputs(
      {super.key,
      required this.invoiceNumber,
      required this.thankYouMessage,
      TextEditingController? paymentDueDays,
      required this.onSaveData,
      required this.onFormValidated,
      required this.onDateSelected})
      : paymentDueDays = paymentDueDays ?? TextEditingController(text: "30");

  @override
  State<InvoiceDetailsInputs> createState() => _InvoiceDetailsInputsState();
}

class _InvoiceDetailsInputsState extends State<InvoiceDetailsInputs> {
  final _keyForm = GlobalKey<FormState>();
  final String _error = "";
  late DateTime _invoiceStartDate;

  @override
  void initState() {
    super.initState();
    _invoiceStartDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _keyForm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: widget.invoiceNumber,
            decoration: const InputDecoration(labelText: 'Invoice Number'),
            validator: _validateInvoiceNumber,
          ),
          TextFormField(
            controller: widget.thankYouMessage,
            decoration: const InputDecoration(labelText: 'Greetings Message'),
          ),
          TextFormField(
            controller: widget.paymentDueDays,
            keyboardType: TextInputType.number,
            decoration:
                const InputDecoration(labelText: 'Payment is due (Days).'),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              FilteringTextInputFormatter.allow(
                RegExp(r'^(?:[1-9]?[0-9]?|[1-2][0-9]{2}|3[0-5][0-9]|360)$'),
              ),
            ],
            validator: _validateDueDays,
          ),
          const SizedBox(height: Constants.padding16),
          DatePicker(
            onDateSelected: (selectedDate) {
              setState(() {
                widget.onDateSelected(selectedDate!);
              });
            },
            selectedDate: _invoiceStartDate,
            buttonText: "Pick Invoice Date",
            startingDate: DateTime(2000),
            backgroundColor: Colors.red,
          ),
          const SizedBox(height: Constants.padding16),
          CustomFloatingButton(
            onPressed: () {
              if (_keyForm.currentState!.validate()) {
                widget.onSaveData();
                widget.onFormValidated(true);
              }
            },
            buttonText: 'Apply',
            backgroundColor: Pallete.gradient3,
          ),
        ],
      ),
    );
  }

  String? _validateInvoiceNumber(String? value) {
    if (value == null || value.isEmpty) {
      return _error;
    }

    return null;
  }

  String? _validateDueDays(String? value) {
    if (value == null || value.isEmpty) {
      return _error;
    }
    final intValue = int.tryParse(value);
    if (intValue == null || intValue < 1 || intValue > 360) {
      return _error;
    }
    return null;
  }
}
