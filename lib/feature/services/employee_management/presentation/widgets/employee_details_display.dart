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
    return Card(
      elevation: 7,
      color: Colors.orange.withOpacity(0.3),
      shadowColor: Colors.red,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.radius15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(Constants.padding8),
        child: Column(
          children: [
            EmployeeDisplayRow(
              icon: Icons.person,
              label: "Full Name",
              text:
                  " ${employee.employeeFirstName} ${employee.employeeLastName}",
            ),
            const SizedBox(height: Constants.padding16),
            EmployeeDisplayRow(
              icon: Icons.sensor_occupied,
              label: "Role",
              text: " ${employee.employeeRole} ",
            ),
            const SizedBox(height: Constants.padding16),
            EmployeeDisplayRow(
              icon: Icons.email,
              label: "Email",
              text: " ${employee.employeeEmail} ",
            ),
            const SizedBox(height: Constants.padding16),
            EmployeeDisplayRow(
              icon: Icons.rate_review,
              label: "Tasks done",
              text: employee.tasksDone.isNotEmpty
                  ? " ${employee.tasksDone.length} "
                  : "No tasks done yet",
            ),
            const SizedBox(height: Constants.padding16),
            EmployeeDisplayRow(
              icon: Icons.data_exploration,
              label: "Joined",
              text:
                  " ${DateFormatHelper.dateFormat(employee.employeeDateJoined)} ",
            ),
          ],
        ),
      ),
    );
  }
}
