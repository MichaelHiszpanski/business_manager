import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Meeting {
  String eventName;
  String eventDescription;
  DateTime startDate;
  DateTime finishDate;
  Color backgroundColor;
  bool isAllDay;

  Meeting(this.eventName, this.eventDescription, this.startDate,
      this.finishDate, this.backgroundColor, this.isAllDay);

  @override
  String toString() {
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return 'Meeting(eventName: $eventName, eventDescription: $eventDescription, '
        'startDate: ${formatter.format(startDate)}, '
        'finishDate: ${formatter.format(finishDate)}, '
        'isAllDay: $isAllDay)';
  }
}
