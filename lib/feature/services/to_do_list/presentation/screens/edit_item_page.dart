import 'package:business_manager/core/tools/constants.dart';
import 'package:business_manager/core/widgets/priority_dropdown/priority_dropdown.dart';
import 'package:business_manager/core/enums/piority_level_enum.dart';
import 'package:business_manager/feature/services/to_do_list/models/to_do_item/to_do_item_model.dart';
import 'package:business_manager/feature/services/to_do_list/bloc/to_do_bloc.dart';
import 'package:business_manager/core/widgets/buttons/custom_floating_button.dart';
import 'package:business_manager/feature/services/to_do_list/presentation/widgets/date_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditItemPage extends StatefulWidget {
  final ToDoItem todo;

  const EditItemPage({Key? key, required this.todo}) : super(key: key);

  @override
  State<EditItemPage> createState() => _EditItemPageState();
}

class _EditItemPageState extends State<EditItemPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late PriorityLevelEnum _selectedPriority;
  DateTime? _expiredDateSelected;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.todo.title);
    _contentController = TextEditingController(text: widget.todo.content);
    _selectedPriority = widget.todo.priority;
    _expiredDateSelected = widget.todo.expiredDate;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _validateToDoItem() {
    if (_formKey.currentState!.validate()) {
      final updatedToDo = ToDoItem(
        id: widget.todo.id,
        title: _titleController.text,
        content: _contentController.text,
        priority: _selectedPriority,
        expiredDate: _expiredDateSelected,
      );

      context.read<ToDoBloc>().add(UpdateToDoList(todo: updatedToDo));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit ToDo Item'),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text('Edit Event'),
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    hintText: 'Enter title',
                  ),
                  validator: _validateValue,
                  maxLength: Constants.MAX_LENGHT_TEXT_TITLE,
                ),
                const SizedBox(height: 20),
                TextFormField(
                    controller: _contentController,
                    decoration: const InputDecoration(
                      hintText: 'Content...',
                    ),
                    validator: _validateValue),
                const SizedBox(height: 20),
                PriorityDropdown(
                  selectedPriority: _selectedPriority,
                  onChanged: (PriorityLevelEnum newPriority) {
                    setState(() {
                      _selectedPriority = newPriority;
                    });
                  },
                ),
                const SizedBox(height: 20),
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
                  buttonText: ('Save Changes'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _validateValue(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a to-do title.';
    }
    return null;
  }
}
