import 'package:business_manager/core/theme/colors.dart';
import 'package:business_manager/core/tools/constants.dart';
import 'package:business_manager/core/widgets/buttons/custom_floating_button.dart';
import 'package:flutter/material.dart';

class EmployeeDetailsInputs extends StatefulWidget {
  final TextEditingController employeeFirstName;
  final TextEditingController employeeLastName;
  final TextEditingController employeeEmail;
  final TextEditingController employeeRole;
  final TextEditingController employeeHourlyRate;
  final TextEditingController employeeDateJoined;
  final TextEditingController employeeTaskList;
  final VoidCallback onSaveData;
  final TextEditingController? businessName;
  final bool isBusinessInputText;

  const EmployeeDetailsInputs({
    super.key,
    required this.employeeFirstName,
    required this.employeeLastName,
    required this.employeeEmail,
    required this.employeeRole,
    required this.employeeHourlyRate,
    required this.employeeDateJoined,
    required this.employeeTaskList,
    required this.onSaveData,
    this.businessName,
    this.isBusinessInputText = false,
  });

  @override
  State<EmployeeDetailsInputs> createState() => _EmployeeDetailsInputsState();
}

class _EmployeeDetailsInputsState extends State<EmployeeDetailsInputs> {
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
            controller: widget.employeeFirstName,
            decoration: const InputDecoration(labelText: 'First name'),
            validator:  _validateField,
          ),
          TextFormField(
            controller: widget.employeeLastName,
            decoration: const InputDecoration(labelText: 'Last Name'),
            validator:  _validateField,
          ),
          TextFormField(
            controller: widget.employeeEmail,
            decoration: const InputDecoration(labelText: 'Street Name'),
            validator:  _validateField,
          ),
          TextFormField(
            controller: widget.employeeRole,
            decoration: const InputDecoration(labelText: 'City Name'),
            validator:  _validateField,
          ),
          TextFormField(
            controller: widget.employeeHourlyRate,
            decoration: const InputDecoration(labelText: 'Post Code'),
            validator:  _validateField,
          ),
          TextFormField(
            controller: widget.employeeDateJoined,
            decoration: const InputDecoration(labelText: 'Mobile Number'),
            validator:  _validateField,
          ),
          TextFormField(
            controller: widget.employeeTaskList,
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
