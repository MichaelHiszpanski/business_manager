import 'package:auto_route/annotations.dart';
import 'package:business_manager/core/main_utils/app_routes/app_routes.dart';
import 'package:business_manager/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:business_manager/feature/services/employee_management/bloc/employee_management_bloc.dart';
import 'package:business_manager/feature/services/employee_management/models/employee_model.dart';
import 'package:business_manager/feature/services/employee_management/presentation/widgets/chart_container.dart';
import 'package:business_manager/feature/services/employee_management/presentation/widgets/employee_list_display.dart';
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

  @override
  void initState() {
    super.initState();
    context.read<EmployeeManagementBloc>().add(const LoadEmployeeList());
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
                        onNewEmployeePressed: _handleNewEmployee,
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
                        onNewEmployeePressed: _handleNewEmployee,
                      ),
                      const ChartContainer(
                        employeesNumber: 0,
                      ),
                    ],
                  );
                } else if (state is EmployeeManagementError) {
                  return Row(
                    children: [
                      EmployeeSidePanel(
                        onNewEmployeePressed: _handleNewEmployee,
                      ),
                      const ChartContainer(
                        employeesNumber: 0.0,
                        taskNumber: 0.0,
                        taskDoneNumber: 0.0,
                        otherNumber: 0.0,
                      ),
                    ],
                  );
                } else {
                  return const Center(child: Text("Failed to load employees."));
                }
              },
            ),
            const EmployeeListDisplay(),
          ],
        ),
      ),
    );
  }

  void _handleNewEmployee() {
    Navigator.of(context).pushNamed(AppRoutes.employeeAddNewScreen);
  }
}
