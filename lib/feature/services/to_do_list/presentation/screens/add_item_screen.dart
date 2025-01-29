import 'package:business_manager/core/screens/informations_screen.dart';
import 'package:business_manager/core/theme/colors.dart';
import 'package:business_manager/core/tools/constants.dart';
import 'package:business_manager/core/tools/flutter_helper.dart';
import 'package:business_manager/core/widgets/buttons/button_wrappers/button_wrapper_one.dart';
import 'package:business_manager/core/widgets/custom_app_bar/custom_app_bar.dart';

import 'package:business_manager/core/widgets/priority_dropdown/priority_dropdown.dart';
import 'package:business_manager/core/enums/piority_level_enum.dart';
import 'package:business_manager/feature/services/to_do_list/models/to_do_item/to_do_item_model.dart';
import 'package:business_manager/feature/services/to_do_list/bloc/to_do_bloc.dart';
import 'package:business_manager/core/widgets/buttons/custom_floating_button.dart';
import 'package:business_manager/core/widgets/date_picker/date_picker.dart';
import 'package:business_manager/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class AddItemScreen extends StatefulWidget {
  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _globalKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  final uuid = const Uuid();
  DateTime? _expiredDateSelected;

  PriorityLevelEnum _prioritySelected = PriorityLevelEnum.MEDIUM;

  void _validateToDoItem() {
    if (_globalKey.currentState!.validate()) {
      final todo = ToDoItem(
        id: uuid.v4(),
        title: _titleController.text,
        content: _contentController.text,
        priority: _prioritySelected,
        expiredDate: _expiredDateSelected,
      );
      context.read<ToDoBloc>().add(AddToDoListItem(todo: todo));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: 'Add ToDo Item',
          onMenuPressed: () {},
        ),
        body: SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: const EdgeInsets.all(Constants.padding32),
            child: Form(
              key: _globalKey,
              child: Column(
                children: [
                  Text(
                    'New Event',
                    style: context.text.headlineLarge,
                  ),
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      hintText: 'Enter title',
                    ),
                    validator: _validateValue,
                    maxLength: Constants.MAX_LENGHT_TEXT_TITLE,
                  ),
                  const SizedBox(height: Constants.padding24),
                  TextFormField(
                    controller: _contentController,
                    decoration: const InputDecoration(
                      hintText: 'Content...',
                    ),
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    maxLength: Constants.MAX_LENGHT_TEXT_CONTENT,
                    validator: _validateValue,
                  ),
                  const SizedBox(height: Constants.padding24),
                  PriorityDropdown(
                    selectedPriority: _prioritySelected,
                    onChanged: (PriorityLevelEnum newPriority) {
                      setState(() {
                        _prioritySelected = newPriority;
                      });
                    },
                  ),
                  const SizedBox(height: Constants.padding24),
                  DatePicker(
                    selectedDate: _expiredDateSelected,
                    onDateSelected: (DateTime? selectedDate) {
                      setState(() {
                        _expiredDateSelected = selectedDate;
                      });
                    },
                  ),
                  const SizedBox(height: Constants.padding24),
                  ButtonWrapperOne(
                    child: CustomFloatingButton(
                      onPressed: _validateToDoItem,
                      buttonText: "Add ToDo",
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  String? _validateValue(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter text...';
    }
    return null;
  }
}
