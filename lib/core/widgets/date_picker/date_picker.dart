import 'package:business_manager/core/helpers/date_format_helper.dart';
import 'package:business_manager/core/theme/colors.dart';
import 'package:business_manager/core/tools/flutter_helper.dart';
import 'package:business_manager/core/widgets/buttons/custom_floating_button.dart';
import 'package:flutter/material.dart';

class DatePicker extends StatefulWidget {
  final ValueChanged<DateTime?> onDateSelected;
  final DateTime? selectedDate;
  DateTime? startingDate;
  String? buttonText;
  Color? backgroundColor;

  DatePicker({
    super.key,
    required this.onDateSelected,
    this.selectedDate,
    this.buttonText,
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
    final DateTime? calendarPicker = await showDatePicker(
      context: context,
      initialDate: _expiredDateSelected ?? DateTime.now(),
      firstDate: widget.startingDate ?? DateTime.now(),
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
    return Container(

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _expiredDateSelected == null
                ? 'No Date Selected! ${_expiredDateSelected ?? ""}'
                : 'Selected: ${DateFormatHelper.dateFormat(_expiredDateSelected)}',
            style: context.text.titleMedium,
          ),
          const SizedBox(height: 10),
          CustomFloatingButton(
            onPressed: () => _datePicker(context),
            buttonText: widget.buttonText ?? 'Pick Expiration Date',
            backgroundColor: widget.backgroundColor ?? Pallete.gradient1,
          ),
        ],
      ),
    );
  }
}
