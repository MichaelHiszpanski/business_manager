import 'package:business_manager/core/helpers/date_format_helper.dart';
import 'package:business_manager/core/widgets/buttons/custom_floating_button.dart';
import 'package:flutter/material.dart';

class DatePicker extends StatefulWidget {
  final ValueChanged<DateTime?> onDateSelected;
  final DateTime? selectedDate;

  const DatePicker(
      {super.key, required this.onDateSelected, this.selectedDate});

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime? _expiredDateSelected;

  @override
  void initState() {
    super.initState();
    _expiredDateSelected = widget.selectedDate;
  }

  Future<void> _datePicker(BuildContext context) async {
    final DateTime? calendarPicker = await showDatePicker(
      context: context,
      initialDate: _expiredDateSelected ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2099),
    );
    if (calendarPicker != null && calendarPicker != _expiredDateSelected) {
      setState(() {
        _expiredDateSelected = calendarPicker;
      });
      widget.onDateSelected(_expiredDateSelected);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _expiredDateSelected == null
              ? 'No Date Selected! ${_expiredDateSelected ?? ""}'
              : 'Selected: ${DateFormatHelper.dateFomrat(_expiredDateSelected)}',
          style: const TextStyle(color: Colors.black54),
        ),
        const SizedBox(height: 10),
        CustomFloatingButton(
          onPressed: () => _datePicker(context),
          buttonText: 'Pick Expiration Date',
        ),
      ],
    );
  }
}
