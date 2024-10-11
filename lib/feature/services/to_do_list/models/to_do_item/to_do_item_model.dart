import 'package:business_manager/core/enums/piority_level_enum.dart';
import 'package:equatable/equatable.dart';

class ToDoItem extends Equatable {
  final String id;
  final String title;
  final String content;
  final DateTime dateTimeAdded;
  final DateTime expiredDate;
  final PriorityLevelEnum priority;

  ToDoItem({
    required this.id,
    required this.title,
    required this.content,
    DateTime? dateTimeAdded,
    DateTime? expiredDate,
    this.priority = PriorityLevelEnum.LOW,
  })  : dateTimeAdded = dateTimeAdded ?? DateTime.now(),
        expiredDate = expiredDate ??
            DateTime.now().add(const Duration(days: 60, milliseconds: 30));

  @override
  List<Object?> get props =>
      [id, title, content, dateTimeAdded, expiredDate, priority];
}
