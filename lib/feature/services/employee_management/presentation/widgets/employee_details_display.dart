import 'package:business_manager/core/helpers/date_format_helper.dart';
import 'package:business_manager/core/tools/constants.dart';
import 'package:business_manager/feature/services/employee_management/models/employee_model.dart';
import 'package:business_manager/feature/services/employee_management/presentation/widgets/employee_display_row.dart';
import 'package:flutter/material.dart';

class EmployeeDetailsDisplay extends StatelessWidget {
  final EmployeeModel employee;
  const EmployeeDetailsDisplay({super.key, required this.employee});


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EmployeeDisplayRow(
          icon: Icons.person,
          text: " ${employee.employeeFirstName} ${employee.employeeLastName}",
        ),
        // const SizedBox(height: Constants.padding16),
        // EmployeeDisplayRow(
        //   icon: Icons.perm_identity,
        //   text: " ${employee.employeeID} ",
        // ),
        const SizedBox(height: Constants.padding16),
        EmployeeDisplayRow(
          icon: Icons.sensor_occupied,
          text: " ${employee.employeeRole} ",
        ),
        const SizedBox(height: Constants.padding16),
        EmployeeDisplayRow(
          icon: Icons.email,
          text: " ${employee.employeeEmail} ",
        ),
        const SizedBox(height: Constants.padding16),
        EmployeeDisplayRow(
          icon: Icons.rate_review,
          text: " ${employee.employeeHourlyRate} ",
        ),
        const SizedBox(height: Constants.padding16),
        EmployeeDisplayRow(
          icon: Icons.data_exploration,
          text:
          " ${DateFormatHelper.dateFormatWithTime(employee.employeeDateJoined)} ",
        ),
      ],
    );
  }
}
