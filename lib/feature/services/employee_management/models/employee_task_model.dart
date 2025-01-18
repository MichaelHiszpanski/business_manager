import 'package:equatable/equatable.dart';

class EmployeeTaskModel extends Equatable {
  String? taskID;
  final String taskTitle;
  final String taskDescription;
  final double taskDuration;
  final String employeeID;
  final DateTime? employeeCheckInTime;
  final DateTime? employeeCheckOutTime;
  final bool isDone;

  EmployeeTaskModel({
    this.taskID,
    required this.taskTitle,
    required this.taskDescription,
    required this.taskDuration,
    required this.employeeID,
    this.employeeCheckInTime,
    this.employeeCheckOutTime,
    required this.isDone,
  });

  String get displayName => "$taskTitle ";

  @override
  @override
  List<Object?> get props => [
        taskTitle,
        taskDescription,
        taskDuration,
        employeeID,
        employeeCheckInTime,
        employeeCheckOutTime,
        isDone
      ];
}
