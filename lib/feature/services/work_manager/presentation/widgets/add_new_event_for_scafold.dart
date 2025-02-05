import 'package:business_manager/core/theme/colors.dart';
import 'package:business_manager/core/tools/constants.dart';
import 'package:business_manager/core/tools/flutter_helper.dart';
import 'package:business_manager/core/widgets/buttons/custom_floating_button.dart';
import 'package:business_manager/feature/services/work_manager/presentation/widgets/color_selector.dart';
import 'package:business_manager/feature/services/work_manager/presentation/widgets/custom_dropdown_hours.dart';
import 'package:flutter/material.dart';

class AddNewEventForScafold extends StatelessWidget {
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

  AddNewEventForScafold({
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
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * 0.9,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                const SizedBox(height: Constants.padding16),
            Text('Set Up a New Event Range',style: context.text.headlineSmall,),
                const SizedBox(height: 2* Constants.padding16),
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
                ListTile(
                  title: const Text('From'),
                  subtitle: Text(fromSelectedDate != null &&
                          fromSelectedTime != null
                      ? '${fromSelectedDate!.toLocal().toString().split(' ')[0]} ${fromSelectedTime!.format(context)}'
                      : 'Select Start Date & Time'),
                  trailing: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: selectFromDateTime,
                  ),
                ),
                ListTile(
                  title: const Text('To'),
                  subtitle: Text(
                    toSelectedDate != null && toSelectedTime != null
                        ? '${toSelectedDate!.toLocal().toString().split(' ')[0]} ${toSelectedTime!.format(context)}'
                        : 'Select End Date & Time',
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: selectToDateTime,
                  ),
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
                  backgroundColor: Pallete.gradient2,
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
