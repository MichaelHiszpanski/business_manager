import 'package:business_manager/core/theme/colors.dart';
import 'package:business_manager/core/tools/constants.dart';
import 'package:business_manager/core/tools/flutter_helper.dart';
import 'package:business_manager/core/widgets/buttons/custom_floating_button.dart';
import 'package:business_manager/core/widgets/buttons/primary_button/primary_button.dart';
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
        padding: const EdgeInsets.all(Constants.padding16),
        child: Form(
          key: formKey,
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              const SizedBox(height: 16),
              Text(
                context.strings.work_manager_add_event_title,
                style:
                    context.text.titleLarge?.copyWith(color: Pallete.gradient1),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: controllerName,
                decoration: InputDecoration(
                  labelText: context.strings.work_manager_event_name_label,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return context.strings.work_manager_event_name_error;
                  }
                  return null;
                },
                maxLength: Constants.MAX_LENGHT_TEXT_TITLE,
              ),
              TextFormField(
                controller: controllerDescription,
                decoration: InputDecoration(
                  labelText:
                      context.strings.work_manager_event_description_label,
                ),
                maxLength: Constants.MAX_LENGHT_TEXT_CONTENT,
                maxLines: null,
              ),
              const SizedBox(height: Constants.padding16),
              Text(
                fromSelectedDate != null && fromSelectedTime != null
                    ? '${fromSelectedDate!.toLocal().toString().split(' ')[0]} ${fromSelectedTime!.format(context)}'
                    : context.strings.work_manager_select_start_date_time,
              ),
              const SizedBox(height: Constants.padding16),
              CustomDropDownHours(
                value: eventDurationPerDay,
                selectedHours: onEventDurationPerDay,
              ),
              const SizedBox(height: Constants.padding16),
              ColorSelector(
                initialColor: selectedColor,
                onColorSelected: onColorSelected,
              ),
              const SizedBox(height: Constants.padding16),
              // SwitchListTile(
              //   title: Text(context.strings.work_manager_all_day_event_label),
              //   value: isAllDay,
              //   onChanged: onAllDay,
              // ),
              const SizedBox(height: Constants.padding16),
              // CustomFloatingButton(
              //   onPressed: addMeeting,
              //   buttonText: context.strings.work_manager_button_accept,
              //   backgroundColor: Pallete.gradient2,
              // ),
              PrimaryButton(
                onPressed: addMeeting,
                buttonText: context.strings.work_manager_button_accept,
              ),
              const SizedBox(height: Constants.padding42),
            ],
          ),
        ),
      ),
    );
  }
}
