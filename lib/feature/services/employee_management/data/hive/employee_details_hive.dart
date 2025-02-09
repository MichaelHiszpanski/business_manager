import 'package:business_manager/core/storage_hive/hive_properites.dart';
import 'package:business_manager/feature/services/employee_management/data/hive/tasks_done_hive.dart';
import 'package:business_manager/feature/services/employee_management/models/task_done_model.dart';
import 'package:hive/hive.dart';
import 'employee_task_hive.dart';

part 'employee_details_hive.g.dart';

@HiveType(typeId: HiveProperties.employeeModelID)
class EmployeeDetailsHive {
  @HiveField(HiveEmployeeDetailsProperties.employeeID)
  final String? employeeID;

  @HiveField(HiveEmployeeDetailsProperties.employeeFirstName)
  final String employeeFirstName;

  @HiveField(HiveEmployeeDetailsProperties.employeeLastName)
  final String employeeLastName;

  @HiveField(HiveEmployeeDetailsProperties.employeeEmail)
  final String employeeEmail;

  @HiveField(HiveEmployeeDetailsProperties.employeeRole)
  final String employeeRole;

  @HiveField(HiveEmployeeDetailsProperties.tasksDone)
  final List<TasksDoneHive> tasksDone;

  @HiveField(HiveEmployeeDetailsProperties.employeeDateJoined)
  final DateTime employeeDateJoined;

  @HiveField(HiveEmployeeDetailsProperties.employeeTaskList)
  final List<EmployeeTaskHive> employeeTaskList;

  EmployeeDetailsHive({
    this.employeeID,
    required this.employeeFirstName,
    required this.employeeLastName,
    required this.employeeEmail,
    required this.employeeRole,
    required this.tasksDone,
    required this.employeeDateJoined,
    required this.employeeTaskList,
  });

  @override
  String toString() {
    return 'EmployeeHive(employeeID: $employeeID, employeeFirstName: $employeeFirstName, '
        'employeeLastName: $employeeLastName, employeeEmail: $employeeEmail, '
        'employeeRole: $employeeRole, employeeHourlyRate: $tasksDone, '
        'employeeDateJoined: $employeeDateJoined, employeeTaskList: $employeeTaskList)';
  }
}
