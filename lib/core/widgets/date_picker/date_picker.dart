import 'package:business_manager/core/helpers/date_format_helper.dart';
import 'package:business_manager/core/theme/colors.dart';
import 'package:business_manager/core/tools/flutter_helper.dart';
import 'package:business_manager/core/widgets/buttons/custom_floating_button.dart';
import 'package:flutter/material.dart';

class DatePicker extends StatefulWidget {
  final ValueChanged<DateTime?> onDateSelected;
  final DateTime? selectedDate;
  DateTime? startingDate;
  final DateTime? minDate;
  String? buttonText;
  Color? backgroundColor;

  DatePicker({
    super.key,
    required this.onDateSelected,
    this.selectedDate,
    this.buttonText,
    this.minDate,
    this.startingDate,
    this.backgroundColor,
  });

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
    final DateTime initialDate = _expiredDateSelected ?? DateTime.now();
    final DateTime firstDate =
        widget.minDate ?? widget.startingDate ?? DateTime(1980);

    final DateTime? calendarPicker = await showDatePicker(
      context: context,
      initialDate: initialDate.isBefore(firstDate) ? firstDate : initialDate,
      firstDate: firstDate,
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
              : 'Selected: ${DateFormatHelper.dateFormat(_expiredDateSelected)}',
          style: context.text.titleSmall,
        ),
        const SizedBox(height: 10),
        CustomFloatingButton(
          onPressed: () => _datePicker(context),
          buttonText: widget.buttonText ?? 'Pick Expiration Date',
          backgroundColor: widget.backgroundColor ?? Pallete.gradient1,
        ),
      ],
    );
  }
}
