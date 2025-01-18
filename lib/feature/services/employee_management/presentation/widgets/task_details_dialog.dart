import 'package:business_manager/core/helpers/date_format_helper.dart';
import 'package:business_manager/core/tools/flutter_helper.dart';
import 'package:business_manager/feature/services/employee_management/bloc/employee_management_bloc.dart';
import 'package:flutter/material.dart';
import 'package:business_manager/feature/services/employee_management/models/employee_task_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskDetailsDialog extends StatefulWidget {
  final EmployeeTaskModel task;
  final String employeeID;
  final VoidCallback onDelete;
  // final VoidCallback onSave;

  const TaskDetailsDialog({
    Key? key,
    required this.task,
    required this.employeeID,
    required this.onDelete,
    // required this.onSave,
  }) : super(key: key);

  @override
  State<TaskDetailsDialog> createState() => _TaskDetailsDialogState();
}

class _TaskDetailsDialogState extends State<TaskDetailsDialog> {
  late bool _isCompleted;

  @override
  void initState() {
    super.initState();
    _isCompleted = widget.task.isDone;
  }

  void _toggleTaskStatus(BuildContext context) {
    setState(() {
      _isCompleted = !_isCompleted;
    });

    final updatedTask = EmployeeTaskModel(
      taskID: widget.task.taskID,
      taskTitle: widget.task.taskTitle,
      taskDescription: widget.task.taskDescription,
      taskDuration: widget.task.taskDuration,
      employeeID: widget.employeeID,
      employeeCheckInTime: widget.task.employeeCheckInTime,
      employeeCheckOutTime: widget.task.employeeCheckOutTime,
      isDone: _isCompleted,
    );

    context.read<EmployeeManagementBloc>().add(
          UpdateEmployeeTask(
            employeeID: widget.employeeID,
            updatedTask: updatedTask,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.task.taskTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Description: ${widget.task.taskDescription}",
            style: context.text.titleSmall,
          ),
          const SizedBox(height: 8),
          Text(
            "Duration: ${widget.task.taskDuration} hours",
            style: context.text.labelLarge,
          ),
          const SizedBox(height: 8),
          if (widget.task.employeeCheckInTime != null)
            Text(
              "Check-In Time: ${DateFormatHelper.dateFomrat(widget.task.employeeCheckInTime)}",
              style: context.text.labelLarge,
            ),
          if (widget.task.employeeCheckOutTime != null)
            Text(
              "Check-Out Time: ${DateFormatHelper.dateFomrat(widget.task.employeeCheckOutTime)}",
              style: context.text.labelLarge,
            ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Status: ${_isCompleted ? 'Completed' : 'Pending'}",
                style: context.text.titleSmall,
              ),
              Switch(
                value: _isCompleted,
                onChanged: (value) {
                  _toggleTaskStatus(context);
                },
              ),
            ],
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: widget.onDelete,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          child: const Text("Delete"),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Close"),
        ),

      ],
    );
  }
}
