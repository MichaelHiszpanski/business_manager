import 'package:business_manager/core/helpers/date_format_helper.dart';
import 'package:business_manager/core/helpers/validations_helper.dart';
import 'package:business_manager/core/theme/colors.dart';
import 'package:business_manager/core/tools/constants.dart';
import 'package:business_manager/core/widgets/buttons/button_wrappers/button_wrapper_one.dart';
import 'package:business_manager/core/widgets/buttons/custom_floating_button.dart';
import 'package:business_manager/core/widgets/date_picker/date_picker.dart';
import 'package:flutter/material.dart';

class EmployeeDetailsInputs extends StatefulWidget {
  final TextEditingController employeeFirstName;
  final TextEditingController employeeLastName;
  final TextEditingController employeeEmail;
  final TextEditingController employeeRole;
  final TextEditingController tasksDone;
  late DateTime employeeDateJoined;
  final VoidCallback onSaveData;
  final bool existingEmployee;

  EmployeeDetailsInputs({
    super.key,
    required this.employeeFirstName,
    required this.employeeLastName,
    required this.employeeEmail,
    required this.employeeRole,
    required this.tasksDone,
    required this.employeeDateJoined,
    required this.onSaveData,
    required this.existingEmployee,
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
          ),
          const SizedBox(height: Constants.padding16),
          TextFormField(
            controller: widget.employeeLastName,
            decoration: const InputDecoration(labelText: 'Employee last Name'),
            validator: ValidationsHelper.validateTextField,
          ),
          const SizedBox(height: Constants.padding16),
          TextFormField(
            controller: widget.employeeEmail,
            decoration: const InputDecoration(labelText: 'Employee email'),
            validator: ValidationsHelper.validateEmail,
          ),
          const SizedBox(height: Constants.padding16),
          TextFormField(
            controller: widget.employeeRole,
            decoration: const InputDecoration(labelText: 'Employee role'),
            validator: ValidationsHelper.validateTextField,
          ),
          // if (!widget.existingEmployee) ...[
          //   TextFormField(
          //     controller: widget.tasksDone,
          //     decoration: const InputDecoration(labelText: 'Tasks done'),
          //     // validator: ValidationsHelper.validateTextField,
          //     // initialValue: "0",
          //     readOnly: true,
          //   ),
          // ],
          const SizedBox(height: Constants.padding24*2),
          DatePicker(
              onDateSelected: (selectedDate) {
                setState(() {
                  _localEmployeeDateJoined = selectedDate ?? DateTime.now();
                });
              },
              selectedDate: _localEmployeeDateJoined,
              startingDate: DateTime(1980),
              buttonText: "Joined Date"),
          const SizedBox(height: Constants.padding24*2),
          ButtonWrapperOne(
            child: CustomFloatingButton(
              onPressed: () {
                if (_keyForm.currentState!.validate()) {
                  widget.onSaveData();
                }
              },
              buttonText: 'Save',
              backgroundColor: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
