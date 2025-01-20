import 'package:auto_route/auto_route.dart';
import 'package:business_manager/core/helpers/date_format_helper.dart';
import 'package:business_manager/core/main_utils/app_routes/app_routes.dart';
import 'package:business_manager/core/theme/colors.dart';
import 'package:business_manager/core/tools/constants.dart';
import 'package:business_manager/core/tools/flutter_helper.dart';
import 'package:business_manager/core/widgets/buttons/button_wrappers/button_wrapper_one.dart';
import 'package:business_manager/core/widgets/buttons/custom_floating_button.dart';
import 'package:business_manager/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:business_manager/feature/services/employee_management/bloc/employee_management_bloc.dart';
import 'package:business_manager/feature/services/employee_management/models/employee_model.dart';
import 'package:business_manager/feature/services/employee_management/models/employee_task_model.dart';
import 'package:business_manager/feature/services/employee_management/presentation/widgets/add_task_dialog.dart';
import 'package:business_manager/feature/services/employee_management/presentation/widgets/employee_display_row.dart';
import 'package:business_manager/feature/services/employee_management/presentation/widgets/task_details_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class EmployeeDetailsScreen extends StatelessWidget {
  const EmployeeDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    // if (!args.containsKey('model')) {
    //   return Center(
    //     child: Text(
    //       "Invalid Employee Details or ID.",
    //       style: context.text.headlineLarge,
    //     ),
    //   );
    // }
    final EmployeeModel model = args['model'];

    return Scaffold(
      appBar: CustomAppBar(title: "Employee Details", onMenuPressed: () {}),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Constants.padding32,
              vertical: Constants.padding16,
            ),
            child: Column(
              children: [
                EmployeeDisplayRow(
                  icon: Icons.person,
                  text: " ${model.employeeFirstName} ${model.employeeLastName}",
                ),
                const SizedBox(height: Constants.padding16),
                EmployeeDisplayRow(
                  icon: Icons.perm_identity,
                  text: " ${model.employeeID} ",
                ),
                const SizedBox(height: Constants.padding16),
                EmployeeDisplayRow(
                  icon: Icons.sensor_occupied,
                  text: " ${model.employeeRole} ",
                ),
                const SizedBox(height: Constants.padding16),
                EmployeeDisplayRow(
                  icon: Icons.email,
                  text: " ${model.employeeEmail} ",
                ),
                const SizedBox(height: Constants.padding16),
                EmployeeDisplayRow(
                  icon: Icons.rate_review,
                  text: " ${model.employeeHourlyRate} ",
                ),
                const SizedBox(height: Constants.padding16),
                EmployeeDisplayRow(
                  icon: Icons.data_exploration,
                  text:
                      " ${DateFormatHelper.dateFormatWithTime(model.employeeDateJoined)} ",
                ),
                const SizedBox(height: Constants.padding8),
                Row(
                  children: [
                    Text(
                      "Tasks",
                      style: context.text.headlineMedium,
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AddTaskDialog(employeeID: model.employeeID!);
                          },
                        );
                      },
                      icon: const Icon(Icons.add),
                      iconSize: 32,
                      tooltip: "Add Task",
                    ),
                  ],
                ),
                const SizedBox(height: Constants.padding8),
                BlocBuilder<EmployeeManagementBloc, EmployeeManagementState>(
                  builder: (context, state) {
                    if (state is EmployeeManagementLoaded) {
                      final updatedEmployee = state.employeeDataList.firstWhere(
                        (employee) => employee.employeeID == model.employeeID,
                        orElse: () => model,
                      );

                      if (updatedEmployee.employeeTaskList.isEmpty) {
                        return const Center(
                          child: Text("No tasks available."),
                        );
                      }

                      return Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius:
                              BorderRadius.circular(Constants.padding16),
                        ),
                        padding: const EdgeInsets.all(Constants.padding16),
                        child: ListView.builder(
                          itemCount: updatedEmployee.employeeTaskList.length,
                          itemBuilder: (context, index) {
                            final task =
                                updatedEmployee.employeeTaskList[index];
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
                                    // onSave: () {
                                    //   _saveTaskDetails(
                                    //       context, model.employeeID!, task);
                                    // },
                                  ),
                                );
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.task,
                                      size: 24,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(width: Constants.padding8),
                                    Expanded(
                                      child: Text(
                                        task.taskTitle,
                                        style: context.text.bodyMedium,
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

                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
                const SizedBox(height: Constants.padding16),
                ButtonWrapperOne(
                  child: CustomFloatingButton(
                    onPressed: () {
                      _updatedEmployeeDetails(context, model);
                    },
                    buttonText: "Edit Employee Details",
                    backgroundColor: Colors.transparent,
                  ),
                ),
                const SizedBox(height: Constants.padding16),
                CustomFloatingButton(
                  onPressed: () {
                    _deleteEmployee(context, model.employeeID!);
                  },
                  buttonText: "Delete Employee",
                  backgroundColor: Colors.red,
                ),
                const SizedBox(height: Constants.padding16 * 4),
              ],
            ),
          ),
        ),
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

  void _saveTaskDetails(
    BuildContext context,
    String employeeID,
    EmployeeTaskModel task,
  ) {
    final updatedTask = EmployeeTaskModel(
      taskID: task.taskID,
      taskTitle: task.taskTitle,
      taskDescription: task.taskDescription,
      taskDuration: task.taskDuration,
      employeeID: employeeID,
      employeeCheckInTime: task.employeeCheckInTime,
      employeeCheckOutTime: task.employeeCheckOutTime,
      isDone: task.isDone,
    );

    context.read<EmployeeManagementBloc>().add(
          UpdateEmployeeTask(
            employeeID: employeeID,
            updatedTask: updatedTask,
          ),
        );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Task updated successfully!")),
    );
    Navigator.of(context).pop();
  }

  void _updatedEmployeeDetails(
    BuildContext context,
    EmployeeModel employee,
  ) {
    Navigator.of(context).pushNamed(
      AppRoutes.employeeAddNewScreen,
      arguments: {
        'model': employee,
      },
    );
  }

  void _deleteEmployee(BuildContext context, String employeeID) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Confirm Delete",
            style: TextStyle(color: Colors.red),
          ),
          content: const Text(
            "Do you want to Delete this Employee?",
            style: TextStyle(color: Colors.black87),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                context.read<EmployeeManagementBloc>().add(
                      RemoveEmployee(employeeID: employeeID),
                    );
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text(
                "Delete",
                style: context.text.bodyMedium,
              ),
            ),
          ],
        );
      },
    );
  }
}
