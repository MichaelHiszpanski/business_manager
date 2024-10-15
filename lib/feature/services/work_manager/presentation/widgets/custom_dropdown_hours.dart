import 'package:flutter/material.dart';

class CustomDropDownHours extends StatefulWidget {
  final Function(int) selectedHours;
  final int value;

  const CustomDropDownHours({
    super.key,
    required this.selectedHours,
    this.value = 1,
  });

  @override
  _CustomDropDownHoursState createState() => _CustomDropDownHoursState();
}

class _CustomDropDownHoursState extends State<CustomDropDownHours> {
  late int _selectedHour;

  @override
  void initState() {
    super.initState();
    _selectedHour = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
        value: _selectedHour,
        items: List.generate(
          24,
          (index) {
            int hour = index + 1;

            return DropdownMenuItem<int>(
              value: hour,
              child: Text('$hour hour${hour > 1 ? 's' : ''}'),
            );
          },
        ),
        onChanged: _onSelectedHour);
  }

  void _onSelectedHour(int? value) {
    if (value != null) {
      setState(() {
        _selectedHour = value;
      });
      widget.selectedHours(value);
    }
  }
}
