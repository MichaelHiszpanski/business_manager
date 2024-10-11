import 'package:dissertation_project_app/core/enums/piority_level_enum.dart';
import 'package:flutter/material.dart';

class PriorityDropdown extends StatefulWidget {
  final PriorityLevelEnum selectedPriority;
  final ValueChanged<PriorityLevelEnum> onChanged;

  const PriorityDropdown({
    Key? key,
    required this.selectedPriority,
    required this.onChanged,
  }) : super(key: key);

  @override
  _PriorityDropdownState createState() => _PriorityDropdownState();

  static Color getPriorityColor(PriorityLevelEnum priority) {
    switch (priority) {
      case PriorityLevelEnum.LOW:
        return Colors.green;
      case PriorityLevelEnum.MEDIUM:
        return Colors.amber;
      case PriorityLevelEnum.HIGH:
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}

class _PriorityDropdownState extends State<PriorityDropdown> {
  late PriorityLevelEnum _selectedPriority;

  @override
  void initState() {
    super.initState();
    _selectedPriority = widget.selectedPriority;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: PriorityDropdown.getPriorityColor(_selectedPriority),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.grey.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<PriorityLevelEnum>(
          value: _selectedPriority,
          dropdownColor: PriorityDropdown.getPriorityColor(_selectedPriority),
          isExpanded: true,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
          items: PriorityLevelEnum.values.map((PriorityLevelEnum priority) {
            return DropdownMenuItem<PriorityLevelEnum>(
              value: priority,
              child: Text(
                priority.toString().split('.').last,
                style: TextStyle(
                  backgroundColor: PriorityDropdown.getPriorityColor(priority),
                ),
              ),
            );
          }).toList(),
          onChanged: (PriorityLevelEnum? newValue) {
            setState(() {
              _selectedPriority = newValue!;
            });
            widget.onChanged(_selectedPriority);
          },
        ),
      ),
    );
  }
}
