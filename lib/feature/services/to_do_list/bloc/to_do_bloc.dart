import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:business_manager/core/enums/piority_level_enum.dart';
import 'package:business_manager/core/helpers/local_notification_helper.dart';
import 'package:business_manager/core/storage_hive/hive_properites.dart';
import 'package:business_manager/feature/services/to_do_list/data/to_do_hive/to_do_data_hive.dart';
import 'package:business_manager/feature/services/to_do_list/models/to_do_item/to_do_item_model.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'to_do_event.dart';

part 'to_do_state.dart';

class ToDoBloc extends Bloc<ToDoEvent, ToDoState> {
  ToDoBloc() : super(ToDoInitial()) {
    on<InitialToDo>(_onInitialLoad);
    on<LoadToDoList>(_onLoadToDoList);
    on<AddToDoListItem>(_onAddToDoListItem);
    on<RemoveToDoListItem>(_onRemoveToDoListItem);
    on<UpdateToDoList>(_onUpdateToDoList);
    on<CheckForExpiredItems>(_checkForExpiredItems);
  }

  final List<ToDoItem> _toDoList = [];

  Future<void> _onInitialLoad(
      InitialToDo event, Emitter<ToDoState> emit) async {}

  Future<void> _onLoadToDoList(
      LoadToDoList event, Emitter<ToDoState> emit) async {
    emit(ToDoLoading());

    Box box = await Hive.openBox(HiveToDoListProperties.TO_DO_LIST_DATA_BOX);

    final List<dynamic>? toDoItemsHive =
        await box.get(HiveToDoListProperties.TO_DO_LIST_DATA_KEY);
    _toDoList.clear();
    if (toDoItemsHive != null) {
      List<ToDoItem> toDoItems = toDoItemsHive.map((dynamic item) {
        final toDoItemHive = item as ToDoItemHive;
        return ToDoItem(
          id: toDoItemHive.id,
          title: toDoItemHive.title,
          content: toDoItemHive.content,
          expiredDate: toDoItemHive.expiredDate,
          priority: PriorityLevelEnum.values.firstWhere(
            (priorityLevel) =>
                priorityLevel.toString() == toDoItemHive.priority,
            orElse: () => PriorityLevelEnum.LOW,
          ),
          dateTimeAdded: toDoItemHive.dateTimeAdded,
        );
      }).toList();

      _toDoList.addAll(toDoItems);

      emit(ToDoLoadSuccess(toDoList: List.from(_toDoList)));
    } else {
      emit(const ToDoLoadSuccess(toDoList: []));
    }
  }

  FutureOr<void> _onAddToDoListItem(
      AddToDoListItem event, Emitter<ToDoState> emit) async {
    Box box = await Hive.openBox(HiveToDoListProperties.TO_DO_LIST_DATA_BOX);
    List<dynamic>? getExistingHiveData =
        box.get(HiveToDoListProperties.TO_DO_LIST_DATA_KEY);
    List<ToDoItemHive> toDoNewList = [];

    _toDoList.add(event.todo);

    if (getExistingHiveData != null) {
      toDoNewList = getExistingHiveData.cast<ToDoItemHive>();
    }

    toDoNewList.add(ToDoItemHive(
      id: event.todo.id,
      title: event.todo.title,
      content: event.todo.content,
      expiredDate: event.todo.expiredDate,
      priority: event.todo.priority.toString(),
    ));

    await box.put(HiveToDoListProperties.TO_DO_LIST_DATA_KEY, toDoNewList);
    emit(ToDoLoadSuccess(toDoList: List.from(_toDoList)));
  }

  FutureOr<void> _onRemoveToDoListItem(
      RemoveToDoListItem event, Emitter<ToDoState> emit) async {
    Box box = await Hive.openBox(HiveToDoListProperties.TO_DO_LIST_DATA_BOX);
    List<dynamic>? getExistingHiveData =
        box.get(HiveToDoListProperties.TO_DO_LIST_DATA_KEY);

    _toDoList.removeWhere((todo) => todo.id == event.id);

    if (getExistingHiveData != null) {
      List<ToDoItemHive> toDoNewList = getExistingHiveData.cast<ToDoItemHive>();
      toDoNewList.removeWhere((hiveItem) => hiveItem.id == event.id);

      await box.put(HiveToDoListProperties.TO_DO_LIST_DATA_KEY, toDoNewList);
    }

    NotificationHelper.cancelNotification(event.id.hashCode);

    emit(ToDoLoadSuccess(toDoList: List.from(_toDoList)));
  }

  FutureOr<void> _onUpdateToDoList(
      UpdateToDoList event, Emitter<ToDoState> emit) async {
    final index = _toDoList.indexWhere((todo) => todo.id == event.toDo.id);

    if (index != -1) {
      _toDoList[index] = event.toDo;

      Box box = await Hive.openBox(HiveToDoListProperties.TO_DO_LIST_DATA_BOX);
      List<dynamic>? getExistingHiveData =
          box.get(HiveToDoListProperties.TO_DO_LIST_DATA_KEY);
      List<ToDoItemHive> toDoNewList = [];

      if (getExistingHiveData != null) {
        toDoNewList = getExistingHiveData.cast<ToDoItemHive>();
        toDoNewList.removeWhere((item) => item.id == event.toDo.id);
      }

      toDoNewList.add(ToDoItemHive(
        id: event.toDo.id,
        title: event.toDo.title,
        content: event.toDo.content,
        expiredDate: event.toDo.expiredDate,
        priority: event.toDo.priority.toString(),
      ));

      await box.put(HiveToDoListProperties.TO_DO_LIST_DATA_KEY, toDoNewList);

      emit(ToDoLoadSuccess(toDoList: List.from(_toDoList)));
    }
  }

  FutureOr<void> _checkForExpiredItems(
      CheckForExpiredItems event, Emitter<ToDoState> emit) {
    final now = DateTime.now();
    _toDoList.removeWhere((todo) => todo.expiredDate.isBefore(now));
    _notificationAlertListGenerator(_toDoList);

    emit(ToDoLoadSuccess(toDoList: List.from(_toDoList)));
  }

  void _notificationAlertListGenerator(List<ToDoItem> toDoList) {
    final now = DateTime.now();
    List<ToDoItem> tasksBetweenOneAndThreeDaysLeft = [];
    List<ToDoItem> tasksWithLessThan24HoursLeft = [];

    for (var item in toDoList) {
      final difference = item.expiredDate.difference(now);
      if (item.priority == PriorityLevelEnum.MEDIUM ||
          item.priority == PriorityLevelEnum.HIGH) {
        if (difference.inHours >= 24 && difference.inHours < 72) {
          tasksBetweenOneAndThreeDaysLeft.add(item);
        } else if (difference.inHours < 24) {
          tasksWithLessThan24HoursLeft.add(item);
        }
      }
    }

    if (tasksBetweenOneAndThreeDaysLeft.isNotEmpty) {
      final tasksSummary = _notificationTasksSummary(
          tasksBetweenOneAndThreeDaysLeft, tasksWithLessThan24HoursLeft);
      NotificationHelper.scheduleNotification(
        id: 1,
        title: 'Tasks due in less than 3 days',
        body: tasksSummary,
        scheduledDate: DateTime.now().add(const Duration(minutes: 5)),
      );
    }

    if (tasksWithLessThan24HoursLeft.isNotEmpty) {
      final body = _notificationTasksSummary(
          tasksWithLessThan24HoursLeft, tasksWithLessThan24HoursLeft);
      NotificationHelper.scheduleNotification(
        id: 2,
        title: 'Urgent! Tasks due in less than 24 hours',
        body: body,
        scheduledDate: DateTime.now().add(const Duration(minutes: 5)),
      );
    }
  }

  String _notificationTasksSummary(
      List<ToDoItem> highPriorityTasks, List<ToDoItem> mediumPriorityTasks) {
    final StringBuffer stringBuffer = StringBuffer();
    bool hasHighPriority = highPriorityTasks
        .any((task) => task.priority == PriorityLevelEnum.HIGH);
    bool hasMediumPriority = mediumPriorityTasks
        .any((task) => task.priority == PriorityLevelEnum.MEDIUM);

    if (hasHighPriority) {
      stringBuffer.writeln("*** Priority - HIGH ***");
      for (var task in highPriorityTasks) {
        if (task.priority == PriorityLevelEnum.HIGH) {
          stringBuffer.writeln(
              '- ${task.title}: Due in ${task.expiredDate.difference(DateTime.now()).inHours} hours');
        }
      }
    }

    if (hasMediumPriority) {
      stringBuffer.writeln("*** Priority - Medium ***");
      for (var task in mediumPriorityTasks) {
        if (task.priority == PriorityLevelEnum.MEDIUM) {
          stringBuffer.writeln(
              '- ${task.title}: Due in ${task.expiredDate.difference(DateTime.now()).inHours} hours');
        }
      }
    }

    return stringBuffer.toString();
  }
}
