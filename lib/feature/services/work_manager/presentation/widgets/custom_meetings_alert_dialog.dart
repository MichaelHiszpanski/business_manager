import 'package:business_manager/core/helpers/date_format_helper.dart';
import 'package:business_manager/core/theme/colors.dart';
import 'package:business_manager/core/tools/constants.dart';
import 'package:business_manager/core/tools/flutter_helper.dart';
import 'package:business_manager/feature/services/work_manager/bloc/work_manager_bloc.dart';
import 'package:flutter/material.dart';
import 'package:business_manager/feature/services/work_manager/models/meeting_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomMeetingsAlertDialog extends StatefulWidget {
  final List<MeetingModel> meetings;

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
        style: context.text.titleMedium?.copyWith(color: Pallete.colorFour),
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.75,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.meetings.length,
          itemBuilder: (BuildContext context, int index) {
            final MeetingModel meeting = widget.meetings[index];
            return Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Pallete.gradient1,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(Constants.radius15),
              ),
              margin: const EdgeInsets.only(bottom: Constants.padding12),
              child: ListTile(
                title: RichText(
                  text: TextSpan(
                    style: context.text.bodyLarge,
                    children: [
                      TextSpan(
                        text: '${context.strings.work_manager_task_name}\n',
                        style: context.text.bodySmall
                            ?.copyWith(color: Pallete.gradient1),
                      ),
                      TextSpan(
                        text: meeting.eventName,
                        style: context.text.bodyMedium
                            ?.copyWith(color: Pallete.colorOne),
                      ),
                    ],
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: Constants.padding16),
                    RichText(
                      text: TextSpan(
                        style: context.text.bodyLarge,
                        children: [
                          TextSpan(
                            text:
                                '${context.strings.work_manager_meeting_content_label}\n',
                            style: context.text.bodySmall
                                ?.copyWith(color: Pallete.gradient1),
                          ),
                          TextSpan(
                              text: meeting.eventDescription,
                              style: context.text.bodyMedium
                                  ?.copyWith(color: Pallete.colorOne)),
                        ],
                      ),
                    ),
                    const SizedBox(height: Constants.padding16),
                    Text(
                      '${context.strings.work_manager_meeting_from_label} ${DateFormatHelper.dateFormatWithTime(meeting.startDate)}',
                      style: context.text.labelLarge,
                    ),
                    const SizedBox(height: Constants.padding8),
                    Text(
                      '${context.strings.work_manager_meeting_to_label}       ${DateFormatHelper.dateFormatWithTime(meeting.finishDate)}',
                      style: context.text.labelLarge,
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
              ),
            );
          },
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: _deleteSelectedTask,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          child: Text(
            context.strings.work_manager_button_select_remove,
            style: context.text.bodyMedium,
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
          ),
          child: Text(
            context.strings.work_manager_button_close,
            style: context.text.bodyMedium,
          ),
        ),
      ],
    );
  }

  void _deleteSelectedTask() {
    if (_selectedIndex != null) {
      final meetingToRemove = widget.meetings[_selectedIndex!];

      BlocProvider.of<WorkManagerBloc>(context)
          .add(MeetingRemoveEvent(meeting: meetingToRemove));

      Navigator.of(context).pop();
    }
  }
}
