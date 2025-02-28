import 'package:business_manager/core/helpers/date_format_helper.dart';
import 'package:business_manager/core/theme/colors.dart';
import 'package:business_manager/core/tools/constants.dart';
import 'package:business_manager/core/tools/flutter_helper.dart';
import 'package:business_manager/core/widgets/priority_dropdown/priority_dropdown.dart';
import 'package:business_manager/feature/services/to_do_list/bloc/to_do_bloc.dart';
import 'package:business_manager/feature/services/to_do_list/models/to_do_item/to_do_item_model.dart';
import 'package:business_manager/feature/services/to_do_list/presentation/screens/edit_item_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToDoListItem extends StatelessWidget {
  final ToDoItem todo;

  const ToDoListItem({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Constants.padding4,
        horizontal: Constants.padding12,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.55),
          border: Border.all(
            color: PriorityDropdown.getPriorityColor(todo.priority),
            width: 4,
            style: BorderStyle.solid,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(Constants.radius10),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: Constants.padding8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: context.strings.to_do_item_label_priority,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: todo.priority.toString().split('.').last,
                            style: TextStyle(
                              color: PriorityDropdown.getPriorityColor(
                                  todo.priority),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    constraints: const BoxConstraints(),
                    iconSize: 22,
                    color: Colors.orange,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => EditItemScreen(todo: todo),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    constraints: const BoxConstraints(),
                    iconSize: 22,
                    color: Colors.red,
                    onPressed: () {
                      context.read<ToDoBloc>().add(
                            RemoveToDoListItem(id: todo.id),
                          );
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: Constants.padding8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  todo.title,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Pallete.gradient1),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(Constants.padding8),
              child: SizedBox(
                width: double.infinity,
                height: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${context.strings.to_do_item_label_content} ${todo.content}',
                      style: const TextStyle(color: Colors.black54),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Flexible(
                      fit: FlexFit.loose,
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          '${context.strings.to_do_item_label_expired_on} '
                          '${DateFormatHelper.dateFormatWithTime(todo.expiredDate)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
