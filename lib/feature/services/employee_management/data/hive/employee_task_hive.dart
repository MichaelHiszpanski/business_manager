import 'package:business_manager/core/storage_hive/hive_properites.dart';
import 'package:hive/hive.dart';

part 'employee_task_hive.g.dart';

@HiveType(typeId: HiveProperties.employeeTaskModelID)
class EmployeeTaskHive {
  @HiveField(0)
  final String? taskID;

  @HiveField(1)
  final String taskTitle;

  @HiveField(2)
  final String taskDescription;

  @HiveField(3)
  final double taskDuration;

  @HiveField(4)
  final String employeeID;

  @HiveField(5)
  final DateTime? employeeCheckInTime;

  @HiveField(6)
  final DateTime? employeeCheckOutTime;

  @HiveField(7)
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