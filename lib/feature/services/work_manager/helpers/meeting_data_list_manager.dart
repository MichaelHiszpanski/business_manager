import 'package:business_manager/feature/services/work_manager/models/meeting_model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart' as sf;

class MeetingDataListManager extends sf.CalendarDataSource {
  MeetingDataListManager(List<MeetingModel> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).startDate;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).finishDate;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).backgroundColor;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
  }

  MeetingModel _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final MeetingModel meetingData;
    if (meeting is MeetingModel) {
      meetingData = meeting;
    }

    return meetingData;
  }
}
