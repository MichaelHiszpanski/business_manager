import 'package:business_manager/core/storage_hive/hive_properites.dart';
import 'package:hive/hive.dart';
import 'employee_task_hive.dart';

part 'employee_details_hive.g.dart';

@HiveType(typeId: HiveProperties.employeeModelID)
class EmployeeHive {
  @HiveField(0)
  final String? employeeID;

  @HiveField(1)
  final String employeeFirstName;

  @HiveField(2)
  final String employeeLastName;

  @HiveField(3)
  final String employeeEmail;

  @HiveField(4)
  final String employeeRole;

  @HiveField(5)
  final double employeeHourlyRate;

  @HiveField(6)
  final DateTime employeeDateJoined;

  @HiveField(7)
  final List<EmployeeTaskHive> employeeTaskList;

  EmployeeHive({
    this.employeeID,
    required this.employeeFirstName,
    required this.employeeLastName,
    required this.employeeEmail,
    required this.employeeRole,
    required this.employeeHourlyRate,
    required this.employeeDateJoined,
    required this.employeeTaskList,
  });

  @override
  String toString() {
    return 'EmployeeHive(employeeID: $employeeID, employeeFirstName: $employeeFirstName, '
        'employeeLastName: $employeeLastName, employeeEmail: $employeeEmail, '
        'employeeRole: $employeeRole, employeeHourlyRate: $employeeHourlyRate, '
        'employeeDateJoined: $employeeDateJoined, employeeTaskList: $employeeTaskList)';
  }
}
