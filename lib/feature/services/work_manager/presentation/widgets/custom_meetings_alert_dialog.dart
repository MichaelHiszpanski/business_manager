import 'package:business_manager/core/helpers/date_format_helper.dart';
import 'package:business_manager/feature/services/work_manager/bloc/work_manager_bloc.dart';
import 'package:flutter/material.dart';
import 'package:business_manager/feature/services/work_manager/models/meeting_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomMeetingsAlertDialog extends StatefulWidget {
  final List<Meeting> meetings;

  const CustomMeetingsAlertDialog({super.key, required this.meetings});

  @override
  State<CustomMeetingsAlertDialog> createState() =>
      _CustomMeetingsAlertDialogState();
}

class _CustomMeetingsAlertDialogState extends State<CustomMeetingsAlertDialog> {
  int? _selectedIndex;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Meeting Details'),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.meetings.length,
          itemBuilder: (BuildContext context, int index) {
            final Meeting meeting = widget.meetings[index];
            return ListTile(
              title: Text(meeting.eventName),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                      'From: ${DateFormatHelper.dateFormatWithTime(meeting.startDate)}'),
                  Text(
                      'To: ${DateFormatHelper.dateFormatWithTime(meeting.finishDate)}'),
                  Text('All Day: ${meeting.isAllDay ? 'Yes' : 'No'}'),
                  Text('Content: ${meeting.eventDescription}'),
                ],
              ),
              selectedColor:
                  _selectedIndex != null ? Colors.red.withOpacity(0.8) : null,
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
              },
              selected: _selectedIndex == index,
            );
          },
        ),
      ),
      actions: <Widget>[
        TextButton(
            child: const Text('Select to Remove'),
            onPressed: () {
              if (_selectedIndex != null) {
                final meetingToRemove = widget.meetings[_selectedIndex!];

                BlocProvider.of<WorkManagerBloc>(context)
                    .add(MeetingRemoveEvent(meeting: meetingToRemove));

                Navigator.of(context).pop();
              }
            }),
        TextButton(
          child: const Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
