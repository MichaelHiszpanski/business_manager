import 'package:equatable/equatable.dart';

class EmployeeTaskModel extends Equatable {
  final String taskTitle;
  final String taskDescription;
  final double taskDuration;
  final DateTime employeeDateJoined;
  final DateTime? employeeCheckInTime;
  final DateTime? employeeCheckOutTime;
  final bool isDone;

  const EmployeeTaskModel({
    required this.taskTitle,
    required this.taskDescription,
    required this.taskDuration,
    required this.employeeDateJoined,
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
        employeeDateJoined,
        employeeCheckInTime,
        employeeCheckOutTime,
        isDone
      ];
}
