import 'package:business_manager/core/storage_hive/hive_properites.dart';
import 'package:hive/hive.dart';

part 'employee_task_hive.g.dart';

@HiveType(typeId: HiveProperties.employeeTaskModelID)
class EmployeeTaskHive {
  @HiveField(HiveEmployeeTaskProperties.taskID)
  final String? taskID;

  @HiveField(HiveEmployeeTaskProperties.taskTitle)
  final String taskTitle;

  @HiveField(HiveEmployeeTaskProperties.taskDescription)
  final String taskDescription;

  @HiveField(HiveEmployeeTaskProperties.taskDuration)
  final double taskDuration;

  @HiveField(HiveEmployeeTaskProperties.employeeID)
  final String employeeID;

  @HiveField(HiveEmployeeTaskProperties.employeeCheckInTime)
  final DateTime? employeeCheckInTime;

  @HiveField(HiveEmployeeTaskProperties.employeeCheckOutTime)
  final DateTime? employeeCheckOutTime;

  @HiveField(HiveEmployeeTaskProperties.isDone)
  final bool isDone;

  EmployeeTaskHive({
    this.taskID,
    required this.taskTitle,
    required this.taskDescription,
    required this.taskDuration,
    required this.employeeID,
    this.employeeCheckInTime,
    this.employeeCheckOutTime,
    required this.isDone,
  });

  @override
  String toString() {
    return 'EmployeeTaskHive(taskID: $taskID, taskTitle: $taskTitle, '
        'taskDescription: $taskDescription, taskDuration: $taskDuration, '
        'employeeID: $employeeID, employeeCheckInTime: $employeeCheckInTime, '
        'employeeCheckOutTime: $employeeCheckOutTime, isDone: $isDone)';
  }
}
