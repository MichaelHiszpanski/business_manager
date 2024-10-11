import 'package:business_manager/core/storage_hive/hive_properites.dart';
import 'package:hive/hive.dart';
import 'package:business_manager/core/enums/piority_level_enum.dart';
import 'package:equatable/equatable.dart';

part 'to_do_data_hive.g.dart';

@HiveType(typeId: HiveProperties.toDoListID)
class ToDoItemHive extends Equatable {
  @HiveField(HiveToDoListProperties.id)
  final String id;

  @HiveField(HiveToDoListProperties.title)
  final String title;

  @HiveField(HiveToDoListProperties.content)
  final String content;

  @HiveField(HiveToDoListProperties.dateTimeAdded)
  final DateTime dateTimeAdded;

  @HiveField(HiveToDoListProperties.expiredDate)
  final DateTime expiredDate;

  @HiveField(HiveToDoListProperties.priority)
  final String priority;

  ToDoItemHive({
    required this.id,
    required this.title,
    required this.content,
    DateTime? dateTimeAdded,
    DateTime? expiredDate,
    String? priority,
  })  : dateTimeAdded = dateTimeAdded ?? DateTime.now(),
        expiredDate =
            expiredDate ?? DateTime.now().add(const Duration(days: 60)),
        priority = priority ?? PriorityLevelEnum.LOW.toString().split('.').last;

  // PriorityLevelEnum get priorityEnum => PriorityLevelEnum.values.firstWhere(
  //     (e) => e.toString().split('.').last == priority,
  //     orElse: () => PriorityLevelEnum.LOW);

  @override
  List<Object?> get props =>
      [id, title, content, dateTimeAdded, expiredDate, priority];
}
