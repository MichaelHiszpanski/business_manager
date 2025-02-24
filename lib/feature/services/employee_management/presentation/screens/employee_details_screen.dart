import 'package:auto_route/auto_route.dart';
import 'package:business_manager/core/main_utils/app_routes/app_routes.dart';
import 'package:business_manager/core/screens/load_app_data_screen.dart';
import 'package:business_manager/core/tools/app_properties.dart';
import 'package:business_manager/core/tools/constants.dart';
import 'package:business_manager/core/tools/flutter_helper.dart';
import 'package:business_manager/core/widgets/buttons/custom_floating_button.dart';
import 'package:business_manager/core/widgets/buttons/primary_button/primary_button.dart';
import 'package:business_manager/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:business_manager/feature/services/employee_management/bloc/employee_management_bloc.dart';
import 'package:business_manager/feature/services/employee_management/models/employee_model.dart';
import 'package:business_manager/feature/services/employee_management/presentation/widgets/add_task_dialog.dart';
import 'package:business_manager/feature/services/employee_management/presentation/widgets/employee_details_display.dart';
import 'package:business_manager/feature/services/employee_management/presentation/widgets/employee_tasks_list_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class EmployeeDetailsScreen extends StatelessWidget {
  const EmployeeDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final EmployeeModel model = args['model'];
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(title: "Employee Details", onMenuPressed: () {}),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AppProperties.imageEmployeeDetails,
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: IntrinsicHeight(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Constants.padding32,
                    vertical: Constants.padding16,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: Constants.padding46 * 2.1),
                      BlocBuilder<EmployeeManagementBloc,
                          EmployeeManagementState>(
                        builder: (context, state) {
                          if (state is EmployeeManagementLoaded) {
                            final updatedEmployee =
                                state.employeeDataList.firstWhere(
                              (employee) =>
                                  employee.employeeID == model.employeeID,
                              orElse: () => model,
                            );
                            return EmployeeDetailsDisplay(
                              employee: updatedEmployee,
                            );
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                      const SizedBox(height: Constants.padding16),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(Constants.radius30),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: Constants.padding16,
                              vertical: Constants.padding8,
                            ),
                            child: Text(
                              "Tasks",
                              style: context.text.headlineMedium
                                  ?.copyWith(color: Colors.green),
                            ),
                          ),
                          const Spacer(),
                          SizedBox(
                            height: 40,
                            width: 40,
                            child: FloatingActionButton(
                              backgroundColor: Colors.green,
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AddTaskDialog(
                                      employeeID: model.employeeID!,
                                    );
                                  },
                                );
                              },
                              child: const Icon(
                                Icons.add,
                                size: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: Constants.padding16),
                      Expanded(
                        child: BlocBuilder<EmployeeManagementBloc,
                            EmployeeManagementState>(
                          builder: (context, state) {
                            if (state is EmployeeManagementLoaded) {
                              final updatedEmployee =
                                  state.employeeDataList.firstWhere(
                                (employee) =>
                                    employee.employeeID == model.employeeID,
                                orElse: () => model,
                              );

                              if (updatedEmployee.employeeTaskList.isEmpty) {
                                return Container(
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(
                                      Constants.padding16,
                                    ),
                                  ),
                                  padding:
                                      const EdgeInsets.all(Constants.padding16),
                                  child: const Center(
                                    child: Text("No tasks available."),
                                  ),
                                );
                              }

                              return EmployeeTasksListContainer(
                                updatedEmployee: updatedEmployee,
                                model: model,
                              );
                            } else if (state is EmployeeManagementError) {
                              return const LoadAppDataScreen();
                            }

                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: Constants.padding46),
                      PrimaryButton(
                        onPressed: () {
                          _updatedEmployeeDetails(context, model);
                        },
                        buttonText: "Edit Employee Details",
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
          ),
        ],
      ),
    );
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
