import 'package:business_manager/core/theme/colors.dart';
import 'package:business_manager/core/tools/constants.dart';

import 'package:business_manager/core/widgets/priority_dropdown/priority_dropdown.dart';
import 'package:business_manager/core/enums/piority_level_enum.dart';
import 'package:business_manager/feature/services/to_do_list/models/to_do_item/to_do_item_model.dart';
import 'package:business_manager/feature/services/to_do_list/bloc/to_do_bloc.dart';
import 'package:business_manager/core/widgets/buttons/custom_floating_button.dart';
import 'package:business_manager/feature/services/to_do_list/presentation/widgets/date_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class AddItemPage extends StatefulWidget {
  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
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
        appBar: AppBar(
          title: Text('Add ToDo Item'),
        ),
        body: SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _globalKey,
              child: Column(
                children: [
                  Text('New Event'),
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      hintText: 'Enter title',
                    ),
                    validator: _validateValue,
                    maxLength: Constants.MAX_LENGHT_TEXT_TITLE,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                      controller: _contentController,
                      decoration: InputDecoration(
                        hintText: 'Content...',
                      ),
                      maxLines: null,
                      maxLength: Constants.MAX_LENGHT_TEXT_CONTENT,
                      validator: _validateValue),
                  SizedBox(height: 20),
                  PriorityDropdown(
                    selectedPriority: _prioritySelected,
                    onChanged: (PriorityLevelEnum newPriority) {
                      setState(() {
                        _prioritySelected = newPriority;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  DatePicker(
                    selectedDate: _expiredDateSelected,
                    onDateSelected: (DateTime? selectedDate) {
                      setState(() {
                        _expiredDateSelected = selectedDate;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomFloatingButton(
                    onPressed: _validateToDoItem,
                    buttonText: "Add ToDo",
                    backgroundColor: Pallete.gradient3,
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
