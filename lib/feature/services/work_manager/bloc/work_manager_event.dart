part of 'work_manager_bloc.dart';

sealed class WorkManagerEvent extends Equatable {
  const WorkManagerEvent();
}

class AddMeetingEvent extends WorkManagerEvent {
  final String eventName;
  final String eventDescription;
  final DateTime startDate;
  final DateTime finishDate;
  final Color background;
  final bool isAllDay;

  const AddMeetingEvent({
    required this.eventName,
    required this.eventDescription,
    required this.startDate,
    required this.finishDate,
    required this.background,
    required this.isAllDay,
  });

  @override
  List<Object> get props => [
        eventName,
        eventDescription,
        startDate,
        finishDate,
        background,
        isAllDay
      ];
}

class DisplayMeetingEvent extends WorkManagerEvent {
  const DisplayMeetingEvent();

  @override
  List<Object> get props => [];
}

class MeetingRemoveEvent extends WorkManagerEvent {
  final MeetingModel meeting;

  const MeetingRemoveEvent({required this.meeting});

  @override
  List<Object> get props => [meeting];
}


