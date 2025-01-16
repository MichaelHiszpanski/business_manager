import 'package:auto_route/auto_route.dart';
import 'package:business_manager/core/tools/constants.dart';
import 'package:business_manager/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:business_manager/feature/services/employee_management/presentation/widgets/employee_details_inputs.dart';
import 'package:flutter/material.dart';

@RoutePage()
class EmployeeAddNewScreen extends StatefulWidget {
  const EmployeeAddNewScreen({super.key});

  @override
  State<EmployeeAddNewScreen> createState() => _EmployeeAddNewScreenState();
}

class _EmployeeAddNewScreenState extends State<EmployeeAddNewScreen> {
  final TextEditingController _employeeFirstName = TextEditingController();
  final TextEditingController _employeeLastName = TextEditingController();
  final TextEditingController _employeeEmail = TextEditingController();
  final TextEditingController _employeeRole = TextEditingController();
  final TextEditingController _employeeHourlyRate = TextEditingController();
  final TextEditingController _employeeDateJoined = TextEditingController();
  final TextEditingController _employeeTaskList = TextEditingController();
  // final TextEditingController _businessOwnerEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "New Employee", onMenuPressed: () {}),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(Constants.padding16),
          child: Column(
            children: [
              Text("New Employee"),
              EmployeeDetailsInputs(
                employeeFirstName: _employeeFirstName,
                employeeLastName: _employeeLastName,
                employeeEmail: _employeeEmail,
                employeeRole: _employeeRole,
                employeeHourlyRate: _employeeHourlyRate,
                employeeDateJoined: _employeeDateJoined,
                employeeTaskList: _employeeTaskList,
                onSaveData: (){},
              )
            ],
          ),
        ),
      ),
    );
  }
}
