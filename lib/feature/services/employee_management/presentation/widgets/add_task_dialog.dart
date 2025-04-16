import 'package:business_manager/core/theme/colors.dart';
import 'package:business_manager/core/tools/constants.dart';
import 'package:business_manager/core/tools/flutter_helper.dart';
import 'package:business_manager/core/widgets/buttons/button_wrappers/button_wrapper_one.dart';
import 'package:business_manager/core/widgets/date_picker/date_picker.dart';
import 'package:business_manager/feature/services/employee_management/bloc/employee_management_bloc.dart';
import 'package:business_manager/feature/services/employee_management/models/employee_task_model.dart';
import 'package:business_manager/feature/services/employee_management/presentation/widgets/decoration_line.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class AddTaskDialog extends StatefulWidget {
  final String employeeID;

  const AddTaskDialog({Key? key, required this.employeeID}) : super(key: key);

  @override
  _AddTaskDialogState createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final _taskTitleController = TextEditingController();
  final _taskDescriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final String _error = "Field cannot be empty";
  final uuid = const Uuid();

  DateTime? _checkInTime;
  DateTime? _checkOutTime;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "New Task",
        style: context.text.headlineMedium?.copyWith(color: Pallete.gradient1),
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.65,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _taskTitleController,
                    decoration: inputDecoration("Task Title"),
                    validator: _validateField,
                    maxLength: 50,
                    minLines: 1,
                    maxLines: 5,
                  ),
                  const SizedBox(height: Constants.padding16),
                  TextFormField(
                    controller: _taskDescriptionController,
                    decoration: inputDecoration("Task Description"),
                    validator: _validateField,
                    minLines: 2,
                    maxLength: 200,
                    maxLines: 10,
                  ),
                  const SizedBox(height: Constants.padding32),
                  DatePicker(
                    onDateSelected: (selectedDate) {
                      setState(() {
                        _checkInTime = selectedDate;
                      });
                    },
                    selectedDate: _checkInTime,
                    buttonText: "Check-In Time",
                    startingDate: DateTime(1980),
                    backgroundColor: Colors.green,
                  ),
                  const SizedBox(height: Constants.padding16),
                  DatePicker(
                    onDateSelected: (selectedDate) {
                      setState(() {
                        _checkOutTime = selectedDate;
                      });
                    },
                    selectedDate: _checkOutTime,
                    buttonText: "Check-Out Time",
                    minDate: _checkInTime,
                    startingDate: DateTime(1980),
                    backgroundColor: Colors.blue,
                  ),
                  const SizedBox(height: Constants.padding16),
                  const DecorationLine(lineColor: Pallete.gradient1),
                ],
              ),
            ),
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.red),
          ),
          child: Text(
            "Cancel",
            style: context.text.bodyMedium,
          ),
        ),
        ElevatedButton(
          onPressed: _addEmployeeTask,
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.green),
            elevation: WidgetStateProperty.all(0),
          ),
          child: Text(
            "Add",
            style: context.text.bodyMedium,
          ),
        ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.radius30),
        side: const BorderSide(color: Pallete.gradient1, width: 2),
      ),
    );
  }

  String? _validateField(String? value) {
    if (value == null || value.isEmpty) {
      return _error;
    }

    return null;
  }

  void _addEmployeeTask() {
    if (_formKey.currentState!.validate()) {
      final newTask = EmployeeTaskModel(
        taskID: uuid.v4(),
        taskTitle: _taskTitleController.text.trim(),
        taskDescription: _taskDescriptionController.text.trim(),
        taskDuration: 0.0,
        employeeID: widget.employeeID,
        employeeCheckInTime: _checkInTime,
        employeeCheckOutTime: _checkOutTime,
        isDone: false,
      );

      context.read<EmployeeManagementBloc>().add(
            AddEmployeeTask(
              employeeID: widget.employeeID,
              task: newTask,
            ),
          );
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _taskTitleController.dispose();
    _taskDescriptionController.dispose();
    super.dispose();
  }

  InputDecoration inputDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Pallete.gradient1),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Pallete.colorSix, width: 2),
      ),
    );
  }
}
