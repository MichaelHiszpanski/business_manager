import 'package:business_manager/feature/services/work_manager/bloc/work_manager_bloc.dart';
import 'package:business_manager/feature/services/work_manager/presentation/widgets/add_new_event_for_bottom_sheet.dart';
import 'package:business_manager/feature/services/work_manager/presentation/widgets/add_new_event_for_scafold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewEventScreen extends StatefulWidget {
  final DateTime? selectedDatetime;
  final bool isLastDateVisible;

  const AddNewEventScreen({
    super.key,
    this.selectedDatetime,
    required this.isLastDateVisible,
  });

  @override
  _AddNewEventScreenState createState() => _AddNewEventScreenState();
}

class _AddNewEventScreenState extends State<AddNewEventScreen> {
  final _formKey = GlobalKey<FormState>();
  final _controllerName = TextEditingController();
  final _controllerDescription = TextEditingController();
  DateTime? _fromSelectedDate;
  DateTime? _toSelectedDate;
  TimeOfDay? _fromSelectedTime;
  TimeOfDay? _toSelectedTime;
  bool _isAllDay = false;
  Color _selectedColor = Colors.red;
  int _eventDurationPerDay = 1;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // final arguments = ModalRoute.of(context)?.settings.arguments as Map?;
    // if (arguments != null && arguments['selectedDate'] != null) {
    //   DateTime selectedDate = arguments['selectedDate'];
    //
    //   _isLastDateVisible = arguments['isLastDateVisible'];
    //   _fromSelectedDate = selectedDate;
    //   _fromSelectedTime = TimeOfDay.fromDateTime(selectedDate);
    // }
    if (widget.selectedDatetime != null) {
      _fromSelectedDate = widget.selectedDatetime;
      _fromSelectedTime = TimeOfDay.fromDateTime(widget.selectedDatetime!);
    }
  }

  void _onColorSelected(Color color) {
    setState(() {
      _selectedColor = color;
    });
  }

  Future<void> _selectFromDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        setState(() {
          _fromSelectedDate = pickedDate;
          _fromSelectedTime = pickedTime;
        });
      }
    }
  }

  Future<void> _selectToDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && mounted) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null && mounted) {
        setState(() {
          _toSelectedDate = pickedDate;
          _toSelectedTime = pickedTime;
        });
      }
    }
  }

  DateTime _combineDateAndTime(DateTime date, TimeOfDay time) {
    return DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
  }

  void _addMeeting() {
    if (_formKey.currentState!.validate()) {
      final eventName = _controllerName.text;
      final eventDescription = _controllerDescription.text;
      final from = _combineDateAndTime(
        _fromSelectedDate ?? DateTime.now(),
        _fromSelectedTime ?? TimeOfDay.now(),
      );
      final to = _combineDateAndTime(
        _toSelectedDate ?? from,
        _toSelectedTime ??
            TimeOfDay(hour: from.hour + _eventDurationPerDay, minute: 0),
      );

      if (_isSameDay(from, to)) {
        BlocProvider.of<WorkManagerBloc>(context).add(AddMeetingEvent(
          eventName: eventName,
          eventDescription: eventDescription,
          startDate: from,
          finishDate: to,
          background: _selectedColor.withOpacity(0.4),
          isAllDay: _isAllDay,
        ));
      } else {
        DateTime currentDay = from;
        while (currentDay.isBefore(to)) {
          final dayStart = _combineDateAndTime(
              currentDay, _fromSelectedTime ?? TimeOfDay(hour: 9, minute: 0));
          final dayEnd = dayStart.add(Duration(hours: _eventDurationPerDay));

          BlocProvider.of<WorkManagerBloc>(context).add(AddMeetingEvent(
            eventName: eventName,
            eventDescription: eventDescription,
            startDate: dayStart,
            finishDate: dayEnd,
            background: _selectedColor.withOpacity(0.4),
            isAllDay: _isAllDay,
          ));

          currentDay = currentDay.add(const Duration(days: 1));
        }
      }

      Navigator.of(context).pop();
    }
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  @override
  Widget build(BuildContext context) {
    return widget.isLastDateVisible == true
        ? AddNewEventForScafold(
            formKey: _formKey,
            selectedColor: _selectedColor,
            controllerName: _controllerName,
            controllerDescription: _controllerDescription,
            onColorSelected: _onColorSelected,
            isAllDay: _isAllDay,
            addMeeting: _addMeeting,
            fromSelectedDate: _fromSelectedDate,
            fromSelectedTime: _fromSelectedTime,
            toSelectedDate: _toSelectedDate,
            toSelectedTime: _toSelectedTime,
            selectFromDateTime: () => _selectFromDateTime(context),
            selectToDateTime: () => _selectToDateTime(context),
            eventDurationPerDay: _eventDurationPerDay,
            onEventDurationPerDay: (selectedHours) {
              setState(() {
                _eventDurationPerDay = selectedHours;
              });
            },
            onAllDay: (bool value) {
              setState(() {
                _isAllDay = value;
              });
            },
          )
        : AddNewEventForBottomSheet(
            formKey: _formKey,
            selectedColor: _selectedColor,
            controllerName: _controllerName,
            controllerDescription: _controllerDescription,
            onColorSelected: _onColorSelected,
            isAllDay: _isAllDay,
            addMeeting: _addMeeting,
            fromSelectedDate: _fromSelectedDate,
            fromSelectedTime: _fromSelectedTime,
            toSelectedDate: _toSelectedDate,
            toSelectedTime: _toSelectedTime,
            selectFromDateTime: () => _selectFromDateTime(context),
            selectToDateTime: () => _selectToDateTime(context),
            eventDurationPerDay: _eventDurationPerDay,
            onEventDurationPerDay: (selectedHours) {
              setState(() {
                _eventDurationPerDay = selectedHours;
              });
            },
            onAllDay: (bool value) {
              setState(() {
                _isAllDay = value;
              });
            },
          );
  }
}
