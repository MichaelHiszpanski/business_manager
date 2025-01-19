import 'package:auto_route/annotations.dart';
import 'package:business_manager/core/main_utils/app_routes/app_routes.dart';
import 'package:business_manager/core/theme/colors.dart';
import 'package:business_manager/core/tools/flutter_helper.dart';
import 'package:business_manager/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:business_manager/feature/services/employee_management/bloc/employee_management_bloc.dart';
import 'package:business_manager/feature/services/employee_management/models/employee_model.dart';
import 'package:business_manager/feature/services/employee_management/presentation/widgets/chart_container.dart';
import 'package:business_manager/feature/services/employee_management/presentation/widgets/employee_side_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class EmployeeManagementScreen extends StatefulWidget {
  const EmployeeManagementScreen({super.key});

  @override
  State<EmployeeManagementScreen> createState() =>
      _EmployeeManagementScreenState();
}

class _EmployeeManagementScreenState extends State<EmployeeManagementScreen> {
  int selectedIndex = -1;

  void navigateToProfile(int index, EmployeeModel employee) {
    Navigator.of(context).pushNamed(
      AppRoutes.employeeDetailsScreen,
      arguments: {
        'model': employee,
      },
    );
  }

  void handleNewEmployee() {
    Navigator.of(context).pushNamed(AppRoutes.employeeAddNewScreen);
  }

  void handleDeleteEmployee() {
    print("Delete Employee button pressed");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Employee Management",
        onMenuPressed: () {},
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<EmployeeManagementBloc, EmployeeManagementState>(
              builder: (context, state) {
                if (state is EmployeeManagementLoaded) {
                  final employeeList = state.employeeDataList;
                  final employeesNumber = employeeList.length.toDouble();
                  final taskNumber = employeeList.fold<double>(
                    0,
                    (sum, employee) =>
                        sum + employee.employeeTaskList.length.toDouble(),
                  );
                  final tasksDone = employeeList.fold<double>(
                    0,
                    (sum, employee) =>
                        sum +
                        employee.employeeTaskList
                            .where((task) => task.isDone)
                            .length
                            .toDouble(),
                  );

                  return Row(
                    children: [
                      EmployeeSidePanel(
                        onNewEmployeePressed: handleNewEmployee,
                      ),
                      ChartContainer(
                        employeesNumber: employeesNumber,
                        taskNumber: taskNumber,
                        taskDoneNumber: tasksDone,
                        otherNumber: taskNumber - tasksDone,
                      ),
                    ],
                  );
                } else if (state is EmployeeManagementInitial) {
                  return Row(
                    children: [
                      EmployeeSidePanel(
                        onNewEmployeePressed: handleNewEmployee,
                      ),
                      const ChartContainer(
                        employeesNumber: 0,
                      ),
                    ],
                  );
                } else {
                  return const Center(child: Text("Failed to load employees."));
                }
              },
            ),
            BlocBuilder<EmployeeManagementBloc, EmployeeManagementState>(
              builder: (context, state) {
                if (state is EmployeeManagementLoaded) {
                  final employeeList = state.employeeDataList;

                  return Container(
                    key: const Key("wheelKey"),
                    height: MediaQuery.of(context).size.height * 0.4,
                    decoration: const BoxDecoration(color: Pallete.colorTwo),
                    child: ListWheelScrollView.useDelegate(
                      itemExtent: 50,
                      useMagnifier: true,
                      magnification: 1.5,
                      diameterRatio: 1.5,
                      physics: const FixedExtentScrollPhysics(),
                      onSelectedItemChanged: (index) {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      childDelegate: ListWheelChildBuilderDelegate(
                        builder: (context, index) {
                          if (index < 0 || index >= employeeList.length) {
                            return Text(
                              "No Employee",
                              style: context.text.titleMedium,
                            );
                          }

                          final employee = employeeList[index];
                          return InkWell(
                            onTap: () {
                              navigateToProfile(index, employee);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              color: selectedIndex == index
                                  ? Colors.grey
                                  : Colors.transparent,
                              child: Text(
                                "${employee.employeeFirstName} ${employee.employeeLastName}",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: selectedIndex == index
                                      ? Colors.white
                                      : Colors.white,
                                ),
                              ),
                            ),
                          );
                        },
                        childCount: employeeList.length,
                      ),
                    ),
                  );
                } else if (state is EmployeeManagementInitial) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return const Center(child: Text("Failed to load employees."));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
