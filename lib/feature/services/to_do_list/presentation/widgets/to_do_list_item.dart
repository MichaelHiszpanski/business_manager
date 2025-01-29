import 'package:business_manager/core/helpers/date_format_helper.dart';
import 'package:business_manager/core/tools/constants.dart';
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
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: PriorityDropdown.getPriorityColor(todo.priority),
            width: 3,
            style: BorderStyle.solid,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(Constants.radius10),
          ),
        ),
        child: ListTile(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Priority: ',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: todo.priority.toString().split('.').last,
                          style: TextStyle(
                            color: PriorityDropdown.getPriorityColor(
                              todo.priority,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    padding: const EdgeInsets.all(0),
                    constraints: const BoxConstraints(),
                    iconSize: 20,
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
                    padding: const EdgeInsets.all(0),
                    constraints: const BoxConstraints(),
                    iconSize: 20,
                    color: Colors.red,
                    onPressed: () {
                      context.read<ToDoBloc>().add(
                            RemoveToDoListItem(id: todo.id),
                          );
                    },
                  ),
                ],
              ),
              Text(
                todo.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Content: ${todo.content}',
                      style: const TextStyle(color: Colors.black54),
                      maxLines: 8,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                        'Expired on: ${DateFormatHelper.dateFormatWithTime(todo.expiredDate)}')
                  ],
                ),
              ),
              //  Container(
              // width: 80,
              //  child:
              //      Row(
              //        mainAxisSize: MainAxisSize.min,
              //        mainAxisAlignment: MainAxisAlignment.end,
              //        children: [
              //          IconButton(
              //            icon:const Icon(Icons.edit),
              //            padding:const EdgeInsets.all(0),
              //            constraints:const BoxConstraints(),
              //            iconSize: 20,
              //            color: Colors.orange,
              //            onPressed: () {
              //              Navigator.of(context).push(
              //                MaterialPageRoute(
              //                  builder: (context) => EditItemPage(todo: todo),
              //                ),
              //              );
              //            },
              //          ),
              //          IconButton(
              //            icon: const Icon(Icons.delete),
              //            padding:const EdgeInsets.all(0),
              //            constraints:const BoxConstraints(),
              //            iconSize: 20,
              //            color: Colors.red,
              //            onPressed: () {
              //              context.read<ToDoBloc>().add(
              //                    RemoveToDoListItem(id: todo.id),
              //                  );
              //            },
              //          ),
              //        ],
              //      ),
              //
              //  ),
            ],
          ),
        ),
      ),
    );
  }
}
