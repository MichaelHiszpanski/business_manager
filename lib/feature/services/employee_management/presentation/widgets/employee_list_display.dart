import 'package:business_manager/core/main_utils/app_routes/app_routes.dart';
import 'package:business_manager/core/screens/load_app_data_screen.dart';
import 'package:business_manager/core/theme/colors.dart';
import 'package:business_manager/core/tools/constants.dart';
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeManagementBloc, EmployeeManagementState>(
      builder: (context, state) {
        if (state is EmployeeManagementLoaded) {
          final employeeList = state.employeeDataList;

          return SizedBox(
            key: const Key("wheelKey"),
            height: MediaQuery.of(context).size.height * 0.52,
            child: Container(
              decoration: const BoxDecoration(color: Pallete.colorSix),
              child: employeeList.isEmpty
                  ? Center(
                      child: Column(
                        children: [
                          Text(
                            "Add New Employee.",
                            style: context.text.headlineLarge?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Constants.padding16,
                      ),
                      child: ListWheelScrollView.useDelegate(
                        itemExtent: 60,
                        useMagnifier: true,
                        magnification:1,
                        diameterRatio: 2,
                        physics: const FixedExtentScrollPhysics(),
                        onSelectedItemChanged: (index) {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        childDelegate:
                        ListWheelChildBuilderDelegate(
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
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(Constants.radius30)),
                                  color: selectedIndex == index
                                      ? Colors.white70
                                      : Colors.transparent,
                                ),
                                // padding: const EdgeInsets.symmetric(horizontal: 16.0),

                                child: Row(
                                  children: [
                                    const SizedBox(width: Constants.padding4),
                                    Icon(
                                      Icons.person_4,
                                      size: 34,
                                      color: selectedIndex == index
                                          ? Colors.black
                                          : Pallete.gradient1,
                                    ),
                                    const SizedBox(width: Constants.padding16),
                                    Expanded(
                                      child: Text(
                                        "${employee.employeeFirstName} ${employee.employeeLastName}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: selectedIndex == index
                                              ? Colors.black
                                              : Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          childCount: employeeList.length,
                        ),
                      ),
                    ),
            ),
          );
        } else if (state is EmployeeManagementInitial) {
          return const LoadAppDataScreen();
        } else {
          return const Center(child: Text("Failed to load Employees!"));
        }
      },
    );
  }

  void _navigateToProfile(int index, EmployeeModel employee) {
    Navigator.of(context).pushNamed(
      AppRoutes.employeeDetailsScreen,
      arguments: {
        'model': employee,
      },
    );
  }
}
