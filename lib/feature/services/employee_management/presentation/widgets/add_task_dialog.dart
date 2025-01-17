import 'package:business_manager/core/tools/constants.dart';
import 'package:business_manager/core/widgets/date_picker/date_picker.dart';
import 'package:business_manager/feature/services/employee_management/bloc/employee_management_bloc.dart';
import 'package:business_manager/feature/services/employee_management/models/employee_task_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  DateTime? _checkInTime;
  DateTime? _checkOutTime;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add Task"),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _taskTitleController,
                decoration: const InputDecoration(labelText: "Task Title"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Task title is required";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _taskDescriptionController,
                decoration:
                    const InputDecoration(labelText: "Task Description"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Task description is required";
                  }
                  return null;
                },
              ),
              const SizedBox(height: Constants.padding16),
              const SizedBox(height: Constants.padding16),
              DatePicker(
                onDateSelected: (selectedDate) {
                  setState(() {
                    _checkInTime = selectedDate;
                  });
                },
                selectedDate: _checkInTime,
                buttonText: "Check-In Time",
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
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final newTask = EmployeeTaskModel(
                taskTitle: _taskTitleController.text.trim(),
                taskDescription: _taskDescriptionController.text.trim(),
                taskDuration: 0.0,
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
          },
          child: const Text("Add"),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _taskTitleController.dispose();
    _taskDescriptionController.dispose();
    super.dispose();
  }
}
