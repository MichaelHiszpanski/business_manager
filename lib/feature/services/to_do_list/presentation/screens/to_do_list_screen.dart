import 'dart:async';

import 'package:business_manager/core/screens/load_app_data_screen.dart';
import 'package:business_manager/core/theme/colors.dart';
import 'package:business_manager/core/tools/app_properties.dart';
import 'package:business_manager/core/tools/constants.dart';
import 'package:business_manager/core/tools/flutter_helper.dart';
import 'package:business_manager/core/widgets/buttons/button_wrappers/button_wrapper_one.dart';
import 'package:business_manager/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:business_manager/core/widgets/filter_menu/filter_menu_to_do_list.dart';
import 'package:business_manager/core/enums/fliter_menu_to_do_list_enum.dart';
import 'package:business_manager/core/enums/piority_level_enum.dart';
import 'package:business_manager/feature/services/to_do_list/models/to_do_item/to_do_item_model.dart';
import 'package:business_manager/feature/services/to_do_list/bloc/to_do_bloc.dart';
import 'package:business_manager/feature/services/to_do_list/presentation/widgets/custom_floating_action_button.dart';
import 'package:business_manager/feature/services/to_do_list/presentation/widgets/to_do_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'add_item_screen.dart';

class ToDoListScreen extends StatefulWidget {
  const ToDoListScreen({super.key});

  @override
  State<ToDoListScreen> createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  FilterMenuToDoListEnum _selectedFilter = FilterMenuToDoListEnum.ALL;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ToDoBloc>(context).add(const LoadToDoList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Pallete.whiteColor,
      appBar: CustomAppBar(
        title: context.strings.to_do_app_bar_title,
        onMenuPressed: _filterShowModalBottomSheet,
        isActionButtonAvailable: true,
        titleFontColor: Colors.white,
        iconArrowColor: Colors.white,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AppProperties.imageToDoListScreen,
              fit: BoxFit.fill,
            ),
          ),
          BlocBuilder<ToDoBloc, ToDoState>(
            builder: (context, state) {
              if (state is ToDoInitial) {
                return Center(
                  child: Text(context.strings.to_do_list_empty_message),
                );
              } else if (state is ToDoLoading) {
                return const LoadAppDataScreen();
              } else if (state is ToDoLoadSuccess) {
                final toDoList = _filteredToDos(state.toDoList);
                if (toDoList.isEmpty) {
                  return Center(
                    child: Text(
                      context.strings.to_do_list_empty_message,
                      style: context.text.headlineMedium?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  );
                }
                BlocProvider.of<ToDoBloc>(context)
                    .add(const CheckForExpiredItems());

                return ListWheelScrollView.useDelegate(
                  itemExtent: 210,
                  physics: const FixedExtentScrollPhysics(),
                  diameterRatio: 5,
                  squeeze: 1,
                  childDelegate: ListWheelChildBuilderDelegate(
                    childCount: toDoList.length,
                    builder: (context, index) {
                      final todo = toDoList[index];

                      return ToDoListItem(todo: todo);
                    },
                  ),
                );
              } else if (state is ToDoError) {
                return Padding(
                  padding: const EdgeInsets.all(Constants.padding16),
                  child: Center(
                    child: Text(
                      context.strings.to_do_error_message,
                      style: context.text.headlineSmall?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              } else {
                return const LoadAppDataScreen();
              }
            },
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 60.0),
        child: ButtonWrapperOne(
          child: CustomFloatingActionButton(
            icon: Icons.add,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AddItemScreen()),
              );
            },
            heroTag: "hero_to_do_page",
            backgroundColor: Colors.transparent,
          ),
        ),
      ),
    );
  }

  List<ToDoItem> _filteredToDos(List<ToDoItem> toDoList) {
    switch (_selectedFilter) {
      case FilterMenuToDoListEnum.TITLE:
        return toDoList..sort((a, b) => a.title.compareTo(b.title));
      case FilterMenuToDoListEnum.DATE:
        return toDoList
          ..sort((a, b) => a.dateTimeAdded.compareTo(b.dateTimeAdded));
      case FilterMenuToDoListEnum.PRIORITY:
        return List.from(toDoList)
          ..sort((a, b) => b.priority.index.compareTo(a.priority.index));
      case FilterMenuToDoListEnum.HIGH:
        return toDoList
            .where((todo) => todo.priority == PriorityLevelEnum.HIGH)
            .toList();
      case FilterMenuToDoListEnum.MEDIUM:
        return toDoList
            .where((todo) => todo.priority == PriorityLevelEnum.MEDIUM)
            .toList();
      case FilterMenuToDoListEnum.LOW:
        return toDoList
            .where((todo) => todo.priority == PriorityLevelEnum.LOW)
            .toList();
      default:
        return toDoList;
    }
  }

  void _filterShowModalBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return FilterMenuToDoList(
          onFilterSelected: (filter) {
            setState(() {
              _selectedFilter = filter;
            });
          },
        );
      },
    );
  }
}
