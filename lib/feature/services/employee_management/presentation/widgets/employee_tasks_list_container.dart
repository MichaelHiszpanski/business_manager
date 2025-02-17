import 'package:business_manager/core/tools/constants.dart';
import 'package:business_manager/core/tools/flutter_helper.dart';
import 'package:business_manager/feature/services/employee_management/bloc/employee_management_bloc.dart';
import 'package:business_manager/feature/services/employee_management/models/employee_model.dart';
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
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(Constants.padding16),
      ),
      padding: const EdgeInsets.all(Constants.padding16),
      child: ListView.builder(
        itemCount: updatedEmployee.employeeTaskList.length,
        itemBuilder: (context, index) {
          final task = updatedEmployee.employeeTaskList[index];
          final bool isTaskDone = task.isDone;
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
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                children: [
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
        },
      ),
    );
  }

  void _deleteTask(
    BuildContext context,
    String employeeID,
    String taskTitle,
  ) {
    context.read<EmployeeManagementBloc>().add(
          RemoveEmployeeTask(
            employeeID: employeeID,
            taskTitle: taskTitle,
          ),
        );
    Navigator.of(context).pop();
  }
}
