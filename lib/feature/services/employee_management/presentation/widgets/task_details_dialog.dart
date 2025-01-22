import 'package:business_manager/core/helpers/date_format_helper.dart';
import 'package:business_manager/core/theme/colors.dart';
import 'package:business_manager/core/tools/constants.dart';
import 'package:business_manager/core/tools/flutter_helper.dart';
import 'package:business_manager/core/widgets/buttons/button_wrappers/button_wrapper_two.dart';
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
      title: Text(
        widget.task.taskTitle,
        style: context.text.headlineMedium,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Description: ${widget.task.taskDescription}",
            style: context.text.bodyLarge,
          ),
          const SizedBox(height: Constants.padding16),
          // Text(
          //   "Duration: ${widget.task.taskDuration} hours",
          //   style: context.text.bodyLarge,
          // ),
          const SizedBox(height: Constants.padding16),
          if (widget.task.employeeCheckInTime != null)
            Text(
              "Check-In Time: ${DateFormatHelper.dateFormat(widget.task.employeeCheckInTime)}",
              style: context.text.titleSmall,
            ),
          const SizedBox(height: Constants.padding16),
          if (widget.task.employeeCheckOutTime != null)
            Text(
              "Check-Out Time: ${DateFormatHelper.dateFormat(widget.task.employeeCheckOutTime)}",
              style: context.text.titleSmall,
            ),
          const SizedBox(height: 8),
          ButtonWrapperTwo(
            startColor: _isCompleted ? Colors.orange : Pallete.gradient2,
            endColor: _isCompleted ? Colors.white38 : Colors.lightBlue,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.48,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "Status: ${_isCompleted ? 'Completed' : 'Pending'}",
                      style: _isCompleted
                          ? context.text.titleSmall
                          : context.text.bodyMedium,
                    ),
                  ),
                  Switch(
                    value: _isCompleted,
                    onChanged: (value) {
                      _toggleTaskStatus(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: widget.onDelete,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          child: Text(
            "Delete",
            style: context.text.bodyMedium,
          ),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
          ),
          child: Text(
            "Close",
            style: context.text.bodyMedium,
          ),
        ),
        // TextButton(
        //   onPressed: widget.onSave,
        //   child: const Text("Save"),
        // ),
      ],
    );
  }
}
