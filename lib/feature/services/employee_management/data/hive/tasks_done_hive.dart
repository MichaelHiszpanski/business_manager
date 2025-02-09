import 'package:business_manager/core/storage_hive/hive_properites.dart';
import 'package:hive/hive.dart';

part 'tasks_done_hive.g.dart';

@HiveType(typeId: HiveProperties.employeeTaskDoneID)
class TasksDoneHive {
  @HiveField(HiveTasksDoneProperties.employeeID)
  String? employeeID;

  @HiveField(HiveTasksDoneProperties.isDone)
  final bool isDone;

  @HiveField(HiveTasksDoneProperties.taskID)
  final String taskID;

  TasksDoneHive({
    this.employeeID,
    required this.isDone,
    required this.taskID,
  });

  String get displayName => "$isDone $taskID";
}
