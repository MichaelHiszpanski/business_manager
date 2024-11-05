import 'package:business_manager/core/storage_hive/hive_properites.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

part 'work_manager_hive.g.dart';

@HiveType(typeId: HiveProperties.workManagerID)
class WorkManagerHive {
  @HiveField(HiveWorkManagerProperties.eventName)
  final String eventName;

  @HiveField(HiveWorkManagerProperties.eventDescription)
  final String eventDescription;

  @HiveField(HiveWorkManagerProperties.startDate)
  final DateTime startDate;

  @HiveField(HiveWorkManagerProperties.finishDate)
  final DateTime finishDate;

  @HiveField(HiveWorkManagerProperties.backgroundColor)
  final Color backgroundColor;

  @HiveField(HiveWorkManagerProperties.isAllDay)
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
