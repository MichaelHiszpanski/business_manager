import 'package:business_manager/core/theme/colors.dart';
import 'package:business_manager/core/tools/constants.dart';
import 'package:business_manager/core/tools/flutter_helper.dart';
import 'package:business_manager/core/widgets/custom_dialog/custom_dialog.dart';
import 'package:business_manager/feature/services/employee_management/bloc/employee_management_bloc.dart';
import 'package:business_manager/feature/services/employee_management/models/employee_model.dart';
import 'package:business_manager/feature/services/employee_management/models/employee_task_model.dart';
import 'package:business_manager/feature/services/employee_management/presentation/widgets/task_details_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeeTasksListContainer extends StatelessWidget {
  final EmployeeModel updatedEmployee;
  final EmployeeModel model;

  const EmployeeTasksListContainer({
    super.key,
    required this.updatedEmployee,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(Constants.padding16),
        border: Border.all(color: Pallete.gradient1, width: 2.0),
      ),
      padding: const EdgeInsets.all(Constants.padding16),
      child: ListView.builder(
        itemCount: updatedEmployee.employeeTaskList.length,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          final task = updatedEmployee.employeeTaskList[index];
          final bool isTaskDone = task.isDone;

          return _taskDetails(
            context,
            isTaskDone,
            task,
            index,
          );
        },
      ),
    );
  }

  Widget _taskDetails(
    BuildContext context,
    bool isTaskDone,
    EmployeeTaskModel task,
    int index,
  ) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => TaskDetailsDialog(
            task: task,
            employeeID: model.employeeID!,
            onDelete: () {
              _deleteTask(
                context,
                model.employeeID!,
                task.taskTitle,
              );
            },
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Constants.padding4),
        child: Row(
          children: [
            SizedBox(
              width: 40,
              child: Row(
                children: [
                  Text(
                    "${index + 1}",
                    style: context.text.titleMedium,
                  ),
                  const Spacer(),
                  Text(
                    "-",
                    style: context.text.titleMedium,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.task,
              size: 24,
              color: isTaskDone ? Colors.green : Colors.red,
            ),
            const SizedBox(width: Constants.padding8),
            Expanded(
              child: Text(
                task.taskTitle,
                style: context.text.bodyMedium?.copyWith(
                  color: isTaskDone ? Colors.green : Colors.red,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _deleteTask(
    BuildContext context,
    String employeeID,
    String taskTitle,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(
          title: "Confirm Delete",
          currentItem:taskTitle,
          onConfirm: () {
            context.read<EmployeeManagementBloc>().add(
                  RemoveEmployeeTask(
                    employeeID: employeeID,
                    taskTitle: taskTitle,
                  ),
                );
            Navigator.of(context).pop();
          }, question: 'Do you want to delete this: ', itemType: ' task?',
        );
      },
    );
  }
}
