import 'package:dissertation_project_app/core/enums/fliter_menu_to_do_list_enum.dart';
import 'package:flutter/material.dart';

class FilterMenuToDoList extends StatelessWidget {
  final Function(FilterMenuToDoListEnum) onFilterSelected;

  const FilterMenuToDoList({super.key, required this.onFilterSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: Text('All'),
          onTap: () {
            onFilterSelected(FilterMenuToDoListEnum.ALL);
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text('Title'),
          onTap: () {
            onFilterSelected(FilterMenuToDoListEnum.TITLE);
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text('Date'),
          onTap: () {
            onFilterSelected(FilterMenuToDoListEnum.DATE);
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text('Priority High to Low'),
          onTap: () {
            onFilterSelected(FilterMenuToDoListEnum.PRIORITY);
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text('Priority HIGH'),
          onTap: () {
            onFilterSelected(FilterMenuToDoListEnum.HIGH);
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text('Priority MEDIUM'),
          onTap: () {
            onFilterSelected(FilterMenuToDoListEnum.MEDIUM);
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text('Priority LOW'),
          onTap: () {
            onFilterSelected(FilterMenuToDoListEnum.LOW);
            Navigator.pop(context);
          },
        ),
        const SizedBox(
          height: 50.0,
        )
      ],
    );
  }
}
