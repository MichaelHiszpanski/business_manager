import 'package:business_manager/core/tools/flutter_helper.dart';
import 'package:business_manager/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:business_manager/feature/services/work_manager/bloc/work_manager_bloc.dart';
import 'package:business_manager/feature/services/work_manager/helpers/meeting_data_list_manager.dart';
import 'package:business_manager/feature/services/work_manager/models/meeting_model.dart';
import 'package:business_manager/feature/services/work_manager/presentation/screens/add_new_event_screen.dart';
import 'package:business_manager/feature/services/work_manager/presentation/widgets/custom_meetings_alert_dialog.dart';
import 'package:business_manager/feature/services/work_manager/presentation/widgets/work_manager_left_custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart' as sf;

import '../widgets/work_manager_right_custom_button.dart';

class WorkManagerScreen extends StatefulWidget {
  const WorkManagerScreen({super.key});

  @override
  State<WorkManagerScreen> createState() => _WorkManagerScreenState();
}

class _WorkManagerScreenState extends State<WorkManagerScreen> {
  sf.CalendarView _calendarView = sf.CalendarView.schedule;
  bool toggleButton = true;

  @override
  void initState() {
    super.initState();

    BlocProvider.of<WorkManagerBloc>(context).add(const DisplayMeetingEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: context.strings.work_manager_app_bar_title,
        onMenuPressed: () {},
      ),
      body: BlocBuilder<WorkManagerBloc, WorkManagerState>(
        builder: (context, state) {
          if (state is WorkManagerInitial) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: sf.SfCalendar(
                key: ValueKey(_calendarView),
                view: _calendarView,
                timeSlotViewSettings: const sf.TimeSlotViewSettings(
                  timeIntervalHeight: 60,
                  timeInterval: Duration(minutes: 60),
                  startHour: 1,
                  endHour: 24,
                  timeFormat: 'h:mm a',
                  timeRulerSize: 60,
                ),
                dataSource: MeetingDataListManager(state.meetings),
                onTap: (details) => _onCalendarEventClicked(context, details),
              ),
            );
          } else if (state is WorkManagerLoaded) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: sf.SfCalendar(
                key: ValueKey(_calendarView),
                view: _calendarView,
                timeSlotViewSettings: const sf.TimeSlotViewSettings(
                  timeIntervalHeight: 60,
                  timeInterval: Duration(minutes: 60),
                  startHour: 1,
                  endHour: 24,
                  timeFormat: 'h:mm a',
                  timeRulerSize: 60,
                  timeTextStyle: TextStyle(color: Colors.black),
                ),
                viewHeaderStyle: const sf.ViewHeaderStyle(
                  dateTextStyle: TextStyle(color: Colors.black),
                ),
                dataSource: MeetingDataListManager(state.meetings),
                onTap: (details) => _onCalendarEventClicked(context, details),
                appointmentTextStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
            );
          } else {
            return Center(
              child: Text(context.strings.work_manager_error_message),
            );
          }
        },
      ),
      floatingActionButton: Stack(
        children: <Widget>[
          Positioned(
            bottom: 20,
            left: 20,
            child:
                WorkManagerLeftCustomButton(onItemCliked: _onLeftItemsClicked),
          ),
          Positioned(
            bottom: 20,
            right: 0,
            child: WorkManagerRightCustomButton(
              onItemClicked: (index) => _onRightItemsClicked(index),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddEventBottomSheet(
      BuildContext context, DateTime dateTime, bool isLastDateVisible) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: MediaQuery.of(context).viewInsets.bottom > 0 ? 50 : 0,
          ),
          child: AddNewEventScreen(
              selectedDatetime: dateTime, isLastDateVisible: isLastDateVisible),
        );
      },
    );
  }

  void _onCalendarEventClicked(
      BuildContext context, sf.CalendarTapDetails details) {
    if (details.appointments == null || details.appointments!.isEmpty) {
      if (details.date != null) {
        _showAddEventBottomSheet(context, details.date!, false);
      }
    } else {
      final List<Meeting> meetings = details.appointments!.cast<Meeting>();

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomMeetingsAlertDialog(meetings: meetings);
        },
      );
    }
  }

  void _onLeftItemsClicked(int index) {
    switch (index) {
      case 0:
        setState(() {
          _calendarView = sf.CalendarView.day;
        });
        break;
      case 1:
        setState(() {
          _calendarView = sf.CalendarView.week;
        });
        break;
      case 2:
      default:
        setState(() {
          _calendarView = sf.CalendarView.month;
        });
        break;
    }
  }

  void _onRightItemsClicked(int index) {
    switch (index) {
      case 0:
        _showAddEventBottomSheet(context, DateTime.now(), true);
        break;
      case 1:
        setState(() {
          _calendarView = sf.CalendarView.timelineMonth;
        });
        break;
      case 2:
      default:
        setState(() {
          _calendarView = sf.CalendarView.schedule;
        });
        break;
    }
  }
}
