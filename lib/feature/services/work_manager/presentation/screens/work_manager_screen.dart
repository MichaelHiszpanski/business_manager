import 'dart:developer';

import 'package:business_manager/core/main_utils/app_routes/app_routes.dart';
import 'package:business_manager/feature/services/work_manager/bloc/work_manager_bloc.dart';
import 'package:business_manager/feature/services/work_manager/helpers/meeting_data_list_manager.dart';
import 'package:business_manager/feature/services/work_manager/models/meeting_model.dart';
import 'package:business_manager/feature/services/work_manager/presentation/screens/add_new_event_screen.dart';
import 'package:business_manager/feature/services/work_manager/presentation/widgets/custom_meetings_alert_dialog.dart';
import 'package:business_manager/feature/services/work_manager/presentation/widgets/work_manager_left_custom_button.dart';
import 'package:business_manager/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../widgets/work_manager_right_custom_button.dart';

class WorkManagerScreen extends StatefulWidget {
  const WorkManagerScreen({super.key});

  @override
  State<WorkManagerScreen> createState() => _WorkManagerScreenState();
}

class _WorkManagerScreenState extends State<WorkManagerScreen> {
  CalendarView _calendarView = CalendarView.day;
  bool toggleButton = true;

  @override
  void initState() {
    super.initState();

    BlocProvider.of<WorkManagerBloc>(context).add(const DisplayMeetingEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Work Manager'),
      ),
      body: BlocBuilder<WorkManagerBloc, WorkManagerState>(
        builder: (context, state) {
          if (state is WorkManagerInitial) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: SfCalendar(
                key: ValueKey(_calendarView),
                view: _calendarView,
                timeSlotViewSettings: const TimeSlotViewSettings(
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
              child: SfCalendar(
                key: ValueKey(_calendarView),
                view: _calendarView,
                timeSlotViewSettings: const TimeSlotViewSettings(
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
          } else {
            return const Center(
              child: Text("Something went wrong!"),
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
      BuildContext context, CalendarTapDetails details) {
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
          _calendarView = CalendarView.day;
        });
        break;
      case 1:
        setState(() {
          _calendarView = CalendarView.week;
        });
        break;
      case 2:
        setState(() {
          _calendarView = CalendarView.month;
        });
        break;
      default:
        print("Unknown icon tapped");
    }
  }

  void _onRightItemsClicked(int index) {
    switch (index) {
      case 0:
        // MainApp.navigatorKey.currentState!
        //            .pushNamed(AppRoutes.addNewEventScreen);
        _showAddEventBottomSheet(context, DateTime.now(), true);
        break;
      case 1:
        setState(() {
          _calendarView = CalendarView.week;
        });
        break;
      case 2:
        setState(() {
          _calendarView = CalendarView.month;
        });
        break;
      default:
        print("Unknown icon tapped");
    }
  }
}