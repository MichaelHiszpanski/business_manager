import 'package:auto_route/annotations.dart';
import 'package:business_manager/core/main_utils/app_routes/app_routes.dart';
import 'package:business_manager/core/theme/colors.dart';
import 'package:business_manager/core/tools/flutter_helper.dart';
import 'package:business_manager/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:business_manager/feature/services/employee_management/presentation/widgets/chart_container.dart';
import 'package:business_manager/feature/services/employee_management/presentation/widgets/employee_side_panel.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

@RoutePage()
class EmployeeManagementScreen extends StatefulWidget {
  const EmployeeManagementScreen({super.key});

  @override
  State<EmployeeManagementScreen> createState() =>
      _EmployeeManagementScreenState();
}

class _EmployeeManagementScreenState extends State<EmployeeManagementScreen> {
  int selectedIndex = -1;
  final items = [
    "Hello 1",
    "Hello 2",
    "Hello 3",
    "Hello 4",
    "Hello 5",
    "Hello 6",
    "Hello 7",
    "Hello 8",
    "Hello 9",
    "Hello 1",
    "Hello 2",
    "Hello 3",
    "Hello 4",
    "Hello 5",
    "Hello 6",
    "Hello 7",
    "Hello 8",
    "Hello 9",
  ];

  void navigateToProfile(int index) {
    Navigator.of(context).pushNamed(
      AppRoutes.employeeDetailsScreen,
      arguments: {'index': index, 'item': items[index]},
    );
  }

  void handleNewEmployee() {
    Navigator.of(context).pushNamed(
      AppRoutes.employeeAddNewScreen,
      // arguments: {'index': index, 'item': items[index]},
    );
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
      body: Column(
        children: [
          Row(
            children: [
              EmployeeSidePanel(
                onNewEmployeePressed: handleNewEmployee,
                // onDeleteEmployeePressed: handleDeleteEmployee,
              ),
            const  ChartContainer(
                employeesNumber: 18,
              ),
            ],
          ),
          Container(
            key: const Key("wheellKEy"),
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: const BoxDecoration(color: Pallete.colorTwo),
            child: ListWheelScrollView.useDelegate(
              itemExtent: 50,
              useMagnifier: true,
              magnification: 2,
              diameterRatio: 1.5,
              physics: const FixedExtentScrollPhysics(),
              onSelectedItemChanged: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              childDelegate: ListWheelChildBuilderDelegate(
                builder: (context, index) {
                  if (index < 0 || index >= items.length) {
                    return Text(
                      "No Employee",
                      style: context.text.titleMedium,
                    );
                  }
                  return InkWell(
                    onTap: () {
                      navigateToProfile(index);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      color: selectedIndex == index
                          ? Colors.grey
                          : Colors.transparent,
                      child: Text(
                        items[index],
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
                childCount: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
