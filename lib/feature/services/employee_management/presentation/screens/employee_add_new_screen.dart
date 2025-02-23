import 'package:auto_route/auto_route.dart';
import 'package:business_manager/core/tools/constants.dart';
import 'package:business_manager/core/tools/flutter_helper.dart';
import 'package:business_manager/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:business_manager/feature/services/employee_management/bloc/employee_management_bloc.dart';
import 'package:business_manager/feature/services/employee_management/models/employee_model.dart';
import 'package:business_manager/feature/services/employee_management/presentation/widgets/employee_details_inputs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

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

  late DateTime _employeeDateJoined;
  final uuid = const Uuid();
  EmployeeModel? _existingEmployee;
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isInitialized) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      if (args != null && args['model'] != null) {
        _existingEmployee = args['model'] as EmployeeModel;
        _defaultFieldsValue(_existingEmployee!);
      } else {
        _employeeDateJoined = DateTime.now();
      }
      _isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isExistingEmployee = _existingEmployee == null;
    return Scaffold(
      appBar: CustomAppBar(
        title: isExistingEmployee ? "New Employee" : "Update Employee",
        onMenuPressed: () {},
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Constants.padding32,
              vertical: Constants.padding16,
            ),
            child: Column(
              children: [
                Text(
                  isExistingEmployee ? "New Employee" : "Update Employee",
                  style: context.text.headlineMedium,
                ),
                const SizedBox(height: Constants.padding16),
                EmployeeDetailsInputs(
                  employeeFirstName: _employeeFirstName,
                  employeeLastName: _employeeLastName,
                  employeeEmail: _employeeEmail,
                  employeeRole: _employeeRole,
                  employeeDateJoined: _employeeDateJoined,
                  onSaveData: _saveUpdateEmployee,
                ),
                const SizedBox(height: Constants.padding46)
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _defaultFieldsValue(EmployeeModel employee) {
    _employeeFirstName.text = employee.employeeFirstName;
    _employeeLastName.text = employee.employeeLastName;
    _employeeEmail.text = employee.employeeEmail;
    _employeeRole.text = employee.employeeRole;
    _employeeDateJoined = employee.employeeDateJoined;
  }

  void _saveUpdateEmployee() {
    final updatedEmployee = EmployeeModel(
      employeeID: _existingEmployee?.employeeID ?? uuid.v4(),
      employeeFirstName: _employeeFirstName.text.trim(),
      employeeLastName: _employeeLastName.text.trim(),
      employeeEmail: _employeeEmail.text.trim(),
      employeeRole: _employeeRole.text.trim(),
      tasksDone: [],
      employeeDateJoined: _employeeDateJoined,
      employeeTaskList: _existingEmployee?.employeeTaskList ?? [],
    );

    if (_existingEmployee == null) {
      context
          .read<EmployeeManagementBloc>()
          .add(AddEmployee(employee: updatedEmployee));
    } else {
      context
          .read<EmployeeManagementBloc>()
          .add(UpdateEmployee(updatedEmployee: updatedEmployee));
    }

    Navigator.of(context).pop();
  }
}
