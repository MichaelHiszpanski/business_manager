import 'package:business_manager/core/storage_hive/hive_properites.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

part 'work_manager_hive.g.dart';

@HiveType(typeId: HiveProperties.workManagerID)
class WorkManagerHive {
  @HiveField(0)
  final String eventName;

  @HiveField(1)
  final String eventDescription;

  @HiveField(2)
  final DateTime startDate;

  @HiveField(3)
  final DateTime finishDate;

  @HiveField(4)
  final Color backgroundColor;

  @HiveField(5)
  final bool isAllDay;

  WorkManagerHive({
    required this.eventName,
    required this.eventDescription,
    required this.startDate,
    required this.finishDate,
    required this.backgroundColor,
    required this.isAllDay,
  });

  @override
  String toString() {
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return 'Meeting(eventName: $eventName, eventDescription: $eventDescription, '
        'startDate: ${formatter.format(startDate)}, '
        'finishDate: ${formatter.format(finishDate)}, '
        'isAllDay: $isAllDay)';
  }
}
