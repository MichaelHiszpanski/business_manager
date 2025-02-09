import 'package:business_manager/feature/services/employee_management/models/employee_task_model.dart';
import 'package:equatable/equatable.dart';

class TaskDoneModel extends Equatable {
  String? employeeID;
  final bool isDone;
  final String taskID;

  TaskDoneModel({
    this.employeeID,
    required this.isDone,
    required this.taskID,
  });

  String get displayName => "$isDone $taskID";

  @override
  @override
  List<Object?> get props => [
        employeeID,
        isDone,
        taskID,
      ];
}
