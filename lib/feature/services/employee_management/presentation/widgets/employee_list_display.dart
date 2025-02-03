import 'package:business_manager/core/main_utils/app_routes/app_routes.dart';
import 'package:business_manager/core/theme/colors.dart';
import 'package:business_manager/core/tools/flutter_helper.dart';
import 'package:business_manager/feature/services/employee_management/bloc/employee_management_bloc.dart';
import 'package:business_manager/feature/services/employee_management/models/employee_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeeListDisplay extends StatefulWidget {
  const EmployeeListDisplay({super.key});

  @override
  State<EmployeeListDisplay> createState() => _EmployeeListDisplayState();
}

class _EmployeeListDisplayState extends State<EmployeeListDisplay> {
  int selectedIndex = -1;

  void _navigateToProfile(int index, EmployeeModel employee) {
    Navigator.of(context).pushNamed(
      AppRoutes.employeeDetailsScreen,
      arguments: {
        'model': employee,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeManagementBloc, EmployeeManagementState>(
      builder: (context, state) {
        if (state is EmployeeManagementLoaded) {
          final employeeList = state.employeeDataList;

          return Container(
            key: const Key("wheelKey"),
            height: MediaQuery.of(context).size.height * 0.48,
            decoration: const BoxDecoration(color: Pallete.colorSix),
            child: employeeList.isEmpty
                ? Center(
                    child: Text(
                      "Add New Employee.",
                      style: context.text.headlineLarge,
                    ),
                  )
                : ListWheelScrollView.useDelegate(
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
                            _navigateToProfile(index, employee);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            color: selectedIndex == index
                                ? Colors.black38
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
    );
  }
}
