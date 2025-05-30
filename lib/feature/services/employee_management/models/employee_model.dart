import 'package:business_manager/feature/services/employee_management/models/employee_task_model.dart';
import 'package:business_manager/feature/services/employee_management/models/task_done_model.dart';
import 'package:equatable/equatable.dart';

class EmployeeModel extends Equatable {
  String? employeeID;
  final String employeeFirstName;
  final String employeeLastName;
  final String employeeEmail;
  final String employeeRole;
  final List<TaskDoneModel> tasksDone;
  final DateTime employeeDateJoined;
  final List<EmployeeTaskModel> employeeTaskList;

  EmployeeModel({
    this.employeeID,
    required this.employeeFirstName,
    required this.employeeLastName,
    required this.employeeEmail,
    required this.employeeRole,
    required this.tasksDone,
    required this.employeeDateJoined,
    required this.employeeTaskList,
  });

  String get displayName => "$employeeFirstName $employeeLastName";

  @override
  @override
  List<Object?> get props => [
        employeeID,
        employeeFirstName,
        employeeLastName,
        employeeEmail,
        employeeRole,
        tasksDone,
        employeeDateJoined,
        employeeTaskList,
      ];
}
