import 'package:business_manager/core/helpers/date_format_helper.dart';
import 'package:business_manager/core/theme/colors.dart';
import 'package:business_manager/core/tools/constants.dart';
import 'package:business_manager/core/tools/flutter_helper.dart';
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
      title: Text(
        context.strings.work_manager_meeting_details_title,
        style: TextStyle(color: Colors.green),
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.meetings.length,
          itemBuilder: (BuildContext context, int index) {
            final Meeting meeting = widget.meetings[index];
            return ListTile(
              title: Text(
                meeting.eventName,
                style: context.text.headlineSmall,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: Constants.padding16),
                  Text(
                    '${context.strings.work_manager_meeting_content_label}'
                    ' ${meeting.eventDescription}',
                    style: context.text.bodyLarge
                        ?.copyWith(color: Pallete.gradient1),
                  ),
                  const SizedBox(height: Constants.padding16),
                  Text(
                    '${context.strings.work_manager_meeting_from_label} ${DateFormatHelper.dateFormatWithTime(meeting.startDate)}',
                    style: context.text.bodyLarge,
                  ),
                  const SizedBox(height: Constants.padding8),
                  Text(
                    '${context.strings.work_manager_meeting_to_label}       ${DateFormatHelper.dateFormatWithTime(meeting.finishDate)}',
                    style: context.text.bodyLarge,
                  ),
                  const SizedBox(height: Constants.padding8),
                ],
              ),
              selectedColor:
                  _selectedIndex != null ? Colors.red.withOpacity(0.8) : null,
              selectedTileColor: Colors.red.withOpacity(0.4),
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
            child: Text(context.strings.work_manager_button_select_remove),
            onPressed: () {
              if (_selectedIndex != null) {
                final meetingToRemove = widget.meetings[_selectedIndex!];

                BlocProvider.of<WorkManagerBloc>(context)
                    .add(MeetingRemoveEvent(meeting: meetingToRemove));

                Navigator.of(context).pop();
              }
            }),
        TextButton(
          child: Text(context.strings.work_manager_button_close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
