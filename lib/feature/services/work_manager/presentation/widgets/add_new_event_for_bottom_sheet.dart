import 'package:business_manager/core/tools/constants.dart';
import 'package:business_manager/core/widgets/buttons/custom_floating_button.dart';
import 'package:business_manager/feature/services/work_manager/presentation/widgets/color_selector.dart';
import 'package:business_manager/feature/services/work_manager/presentation/widgets/custom_dropdown_hours.dart';
import 'package:flutter/material.dart';

class AddNewEventForBottomSheet extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  TextEditingController? controllerName;
  TextEditingController? controllerDescription;
  DateTime? fromSelectedDate;
  DateTime? toSelectedDate;
  TimeOfDay? fromSelectedTime;
  TimeOfDay? toSelectedTime;
  Future<void> Function()? selectFromDateTime;
  Future<void> Function()? selectToDateTime;
  final Function(Color color) onColorSelected;
  final Color selectedColor;
  bool isAllDay;
  Function() addMeeting;
  int eventDurationPerDay;
  Function(int index) onEventDurationPerDay;
  Function(bool isAllDay) onAllDay;

  AddNewEventForBottomSheet({
    super.key,
    required this.formKey,
    this.controllerName,
    this.controllerDescription,
    this.fromSelectedDate,
    this.fromSelectedTime,
    this.toSelectedDate,
    this.toSelectedTime,
    this.selectFromDateTime,
    this.selectToDateTime,
    required this.selectedColor,
    required this.onColorSelected,
    required this.isAllDay,
    required this.addMeeting,
    required this.eventDurationPerDay,
    required this.onEventDurationPerDay,
    required this.onAllDay,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: 16.0,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              const SizedBox(height: 16),
              Text('Add New Event'),
              const SizedBox(height: 16),
              TextFormField(
                controller: controllerName,
                decoration: const InputDecoration(
                  labelText: 'Event Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an event name';
                  }
                  return null;
                },
                maxLength: Constants.MAX_LENGHT_TEXT_TITLE,
              ),
              TextFormField(
                controller: controllerDescription,
                decoration: const InputDecoration(
                  labelText: 'Event Description',
                ),
                maxLength: Constants.MAX_LENGHT_TEXT_CONTENT,
                maxLines: null,
              ),
              const SizedBox(height: 16),
              Text(
                fromSelectedDate != null && fromSelectedTime != null
                    ? '${fromSelectedDate!.toLocal().toString().split(' ')[0]} ${fromSelectedTime!.format(context)}'
                    : 'Select Start Date & Time',
              ),
              const SizedBox(height: 16),
              CustomDropDownHours(
                value: eventDurationPerDay,
                selectedHours: onEventDurationPerDay,
              ),
              const SizedBox(height: 16),
              ColorSelector(
                initialColor: selectedColor,
                onColorSelected: onColorSelected,
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('All Day Event'),
                value: isAllDay,
                onChanged: onAllDay,
              ),
              const SizedBox(height: 16),
              CustomFloatingButton(
                onPressed: addMeeting,
                buttonText: 'Accept',
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
