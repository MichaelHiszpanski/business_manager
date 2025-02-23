import 'package:business_manager/core/helpers/validations_helper.dart';
import 'package:business_manager/core/tools/constants.dart';
import 'package:business_manager/core/widgets/buttons/primary_button/primary_button.dart';
import 'package:business_manager/core/widgets/date_picker/date_picker.dart';
import 'package:flutter/material.dart';

class EmployeeDetailsInputs extends StatefulWidget {
  final TextEditingController employeeFirstName;
  final TextEditingController employeeLastName;
  final TextEditingController employeeEmail;
  final TextEditingController employeeRole;
  late DateTime employeeDateJoined;
  final VoidCallback onSaveData;

  EmployeeDetailsInputs({
    super.key,
    required this.employeeFirstName,
    required this.employeeLastName,
    required this.employeeEmail,
    required this.employeeRole,
    required this.employeeDateJoined,
    required this.onSaveData,
  });

  @override
  State<EmployeeDetailsInputs> createState() => _EmployeeDetailsInputsState();
}

class _EmployeeDetailsInputsState extends State<EmployeeDetailsInputs> {
  final _keyForm = GlobalKey<FormState>();
  late DateTime _localEmployeeDateJoined;

  @override
  void initState() {
    super.initState();
    _localEmployeeDateJoined = widget.employeeDateJoined;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _keyForm,
      child: Column(
        children: [
          const SizedBox(height: Constants.padding16),
          TextFormField(
            controller: widget.employeeFirstName,
            decoration: const InputDecoration(labelText: 'Employee first name'),
            validator: ValidationsHelper.validateTextField,
            maxLength: 50,
          ),
          const SizedBox(height: Constants.padding16),
          TextFormField(
            controller: widget.employeeLastName,
            decoration: const InputDecoration(labelText: 'Employee last Name'),
            validator: ValidationsHelper.validateTextField,
            maxLength: 50,
          ),
          const SizedBox(height: Constants.padding16),
          TextFormField(
            controller: widget.employeeEmail,
            decoration: const InputDecoration(labelText: 'Employee email'),
            validator: ValidationsHelper.validateEmail,
            maxLength: 50,
          ),
          const SizedBox(height: Constants.padding16),
          TextFormField(
            controller: widget.employeeRole,
            decoration: const InputDecoration(labelText: 'Employee role'),
            validator: ValidationsHelper.validateTextField,
            maxLength: 30,
          ),
          const SizedBox(height: Constants.padding24 * 2),
          DatePicker(
              onDateSelected: (selectedDate) {
                setState(() {
                  _localEmployeeDateJoined = selectedDate ?? DateTime.now();
                });
              },
              selectedDate: _localEmployeeDateJoined,
              startingDate: DateTime(1980),
              buttonText: "Joined Date"),
          const SizedBox(height: Constants.padding24 * 2),
          PrimaryButton(
            onPressed: () {
              if (_keyForm.currentState!.validate()) {
                widget.onSaveData();
              }
            },
            buttonText: 'Save',
          )
        ],
      ),
    );
  }
}
