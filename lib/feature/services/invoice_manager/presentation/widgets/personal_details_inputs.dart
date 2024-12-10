import 'package:business_manager/core/theme/colors.dart';
import 'package:business_manager/core/tools/constants.dart';
import 'package:business_manager/core/widgets/buttons/custom_floating_button.dart';
import 'package:flutter/material.dart';

class PersonalDetailsInputs extends StatefulWidget {
  final TextEditingController firstName;
  final TextEditingController lastName;
  final TextEditingController street;
  final TextEditingController postCode;
  final TextEditingController city;
  final TextEditingController mobile;
  final TextEditingController email;
  final VoidCallback onSaveData;
  final TextEditingController? businessName;
  final bool isBusinessInputText;

  const PersonalDetailsInputs({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.street,
    required this.postCode,
    required this.city,
    required this.mobile,
    required this.email,
    required this.onSaveData,
    this.businessName,
    this.isBusinessInputText = false,
  });

  @override
  State<PersonalDetailsInputs> createState() => _PersonalDetailsInputsState();
}

class _PersonalDetailsInputsState extends State<PersonalDetailsInputs> {
  final _keyForm = GlobalKey<FormState>();
  final String _error = "";

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _keyForm,
      child: Column(
        children: [
          if (widget.isBusinessInputText) ...[
            TextFormField(
              controller: widget.businessName,
              decoration: const InputDecoration(labelText: 'Business Name'),
              validator:  _validateField,
            ),
          ],
          TextFormField(
            controller: widget.firstName,
            decoration: const InputDecoration(labelText: 'First name'),
            validator:  _validateField,
          ),
          TextFormField(
            controller: widget.lastName,
            decoration: const InputDecoration(labelText: 'Last Name'),
            validator:  _validateField,
          ),
          TextFormField(
            controller: widget.street,
            decoration: const InputDecoration(labelText: 'Street Name'),
            validator:  _validateField,
          ),
          TextFormField(
            controller: widget.city,
            decoration: const InputDecoration(labelText: 'City Name'),
            validator:  _validateField,
          ),
          TextFormField(
            controller: widget.postCode,
            decoration: const InputDecoration(labelText: 'Post Code'),
            validator:  _validateField,
          ),
          TextFormField(
            controller: widget.mobile,
            decoration: const InputDecoration(labelText: 'Mobile Number'),
            validator:  _validateField,
          ),
          TextFormField(
            controller: widget.email,
            decoration: const InputDecoration(labelText: 'Email:'),
            validator:  _validateField,
          ),
          const SizedBox(height: Constants.padding24),
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
  }

  String? _validateField(String? value) {
    if (value == null || value.isEmpty) {
      return _error;
    }

    return null;
  }
}
