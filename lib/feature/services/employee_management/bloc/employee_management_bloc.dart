import 'package:bloc/bloc.dart';
import 'package:business_manager/core/storage_hive/hive_properites.dart';
import 'package:business_manager/feature/services/employee_management/data/hive/employee_details_hive.dart';
import 'package:business_manager/feature/services/employee_management/data/hive/employee_task_hive.dart';
import 'package:business_manager/feature/services/employee_management/data/hive/tasks_done_hive.dart';
import 'package:business_manager/feature/services/employee_management/models/employee_model.dart';
import 'package:business_manager/feature/services/employee_management/models/employee_task_model.dart';
import 'package:business_manager/feature/services/employee_management/models/task_done_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'employee_management_event.dart';

part 'employee_management_state.dart';

class EmployeeManagementBloc
    extends Bloc<EmployeeManagementEvent, EmployeeManagementState> {
  final List<EmployeeModel> _employeeList = [];

  EmployeeManagementBloc() : super(EmployeeManagementInitial()) {
    on<InitialEmployeeManagement>(_onInitialLoad);
    on<AddEmployee>(_onAddEmployee);
    on<RemoveEmployee>(_onRemoveEmployee);
    on<UpdateEmployee>(_onUpdateEmployee);
    on<LoadEmployeeList>(_onLoadedEmployeeList);
    on<AddEmployeeTask>(_onAddEmployeeTask);
    on<RemoveEmployeeTask>(_onRemoveEmployeeTask);
    on<CheckForOverdueTasks>((event, emit) {});
    on<UpdateEmployeeTask>(_onUpdateEmployeeTask);
  }

  Future<void> _onInitialLoad(
    InitialEmployeeManagement event,
    Emitter<EmployeeManagementState> emit,
  ) async {
    emit(EmployeeManagementInitial());
  }

  Future<void> _onLoadedEmployeeList(
    LoadEmployeeList event,
    Emitter<EmployeeManagementState> emit,
  ) async {
    emit(EmployeeManagementLoading());

    Box box = await Hive.openBox(
        HiveEmployeeDetailsProperties.TO_EMPLOYEE_DETAILS_DATA_BOX);

    final List<dynamic>? employeeListHive = await box
        .get(HiveEmployeeDetailsProperties.TO_EMPLOYEE_DETAILS_DATA_KEY);

    _employeeList.clear();

    if (employeeListHive != null) {
      List<EmployeeModel> employeeModel = employeeListHive.map((dynamic item) {
        final employeeModelHive = item as EmployeeDetailsHive;

        final List<EmployeeTaskModel> taskList =
            employeeModelHive.employeeTaskList.map((task) {
          return EmployeeTaskModel(
            taskTitle: task.taskTitle,
            taskDescription: task.taskDescription,
            taskDuration: task.taskDuration,
            employeeID: task.employeeID,
            employeeCheckInTime: task.employeeCheckInTime,
            employeeCheckOutTime: task.employeeCheckOutTime,
            isDone: task.isDone,
          );
        }).toList();

        final List<TaskDoneModel> tasksDoneList =
            employeeModelHive.tasksDone.map((taskDone) {
          return TaskDoneModel(
            employeeID: taskDone.employeeID,
            isDone: taskDone.isDone,
            taskID: taskDone.taskID,
          );
        }).toList();

        return EmployeeModel(
            employeeID: employeeModelHive.employeeID,
            employeeFirstName: employeeModelHive.employeeFirstName,
            employeeLastName: employeeModelHive.employeeLastName,
            employeeEmail: employeeModelHive.employeeEmail,
            employeeRole: employeeModelHive.employeeRole,
            tasksDone: tasksDoneList,
            employeeDateJoined: employeeModelHive.employeeDateJoined,
            employeeTaskList: taskList);
      }).toList();

      _employeeList.addAll(employeeModel);
      emit(
          EmployeeManagementLoaded(employeeDataList: List.from(_employeeList)));
    } else {
      emit(EmployeeManagementError());
      _employeeList.clear();
    }
  }

  Future<void> _onAddEmployee(
    AddEmployee event,
    Emitter<EmployeeManagementState> emit,
  ) async {
    final box = await Hive.openBox(
        HiveEmployeeDetailsProperties.TO_EMPLOYEE_DETAILS_DATA_BOX);
    List<dynamic>? getExistingHiveData =
        box.get(HiveEmployeeDetailsProperties.TO_EMPLOYEE_DETAILS_DATA_KEY);
    List<EmployeeDetailsHive> employeeList = [];

    _employeeList.add(event.employee);

    if (getExistingHiveData != null) {
      employeeList = getExistingHiveData.cast<EmployeeDetailsHive>();
    }

    final tasksDoneHive = event.employee.tasksDone.map((taskDone) {
      return TasksDoneHive(
        employeeID: taskDone.employeeID,
        isDone: taskDone.isDone,
        taskID: taskDone.taskID,
      );
    }).toList();

    final employeeTasksHive = event.employee.employeeTaskList.map((task) {
      return EmployeeTaskHive(
        taskTitle: task.taskTitle,
        taskDescription: task.taskDescription,
        taskDuration: task.taskDuration,
        employeeID: task.employeeID,
        employeeCheckInTime: task.employeeCheckInTime,
        employeeCheckOutTime: task.employeeCheckOutTime,
        isDone: task.isDone,
      );
    }).toList();

    final newEmployeeHive = EmployeeDetailsHive(
      employeeID: event.employee.employeeID,
      employeeFirstName: event.employee.employeeFirstName,
      employeeLastName: event.employee.employeeLastName,
      employeeEmail: event.employee.employeeEmail,
      employeeRole: event.employee.employeeRole,
      tasksDone: tasksDoneHive,
      employeeDateJoined: event.employee.employeeDateJoined,
      employeeTaskList: employeeTasksHive,
    );

    employeeList.add(newEmployeeHive);
    await box.put(
      HiveEmployeeDetailsProperties.TO_EMPLOYEE_DETAILS_DATA_KEY,
      employeeList,
    );

    emit(EmployeeManagementLoaded(employeeDataList: List.from(_employeeList)));
  }

  Future<void> _onRemoveEmployee(
    RemoveEmployee event,
    Emitter<EmployeeManagementState> emit,
  ) async {
    final box = await Hive.openBox(
        HiveEmployeeDetailsProperties.TO_EMPLOYEE_DETAILS_DATA_BOX);
    List<dynamic>? getExistingHiveData =
        box.get(HiveEmployeeDetailsProperties.TO_EMPLOYEE_DETAILS_DATA_KEY);

    _employeeList
        .removeWhere((employee) => employee.employeeID == event.employeeID);

    if (getExistingHiveData != null) {
      List<EmployeeDetailsHive> updatedHiveList =
          getExistingHiveData.cast<EmployeeDetailsHive>();

      updatedHiveList.removeWhere(
        (employee) => employee.employeeID == event.employeeID,
      );

      await box.put(
        HiveEmployeeDetailsProperties.TO_EMPLOYEE_DETAILS_DATA_KEY,
        updatedHiveList,
      );
    }

    emit(EmployeeManagementLoaded(employeeDataList: List.from(_employeeList)));
  }

  Future<void> _onUpdateEmployee(
    UpdateEmployee event,
    Emitter<EmployeeManagementState> emit,
  ) async {
    final index = _employeeList.indexWhere(
        (employee) => employee.employeeID == event.updatedEmployee.employeeID);

    if (index != -1) {
      _employeeList[index] = event.updatedEmployee;

      final box = await Hive.openBox(
          HiveEmployeeDetailsProperties.TO_EMPLOYEE_DETAILS_DATA_BOX);
      List<dynamic>? getExistingHiveData =
          box.get(HiveEmployeeDetailsProperties.TO_EMPLOYEE_DETAILS_DATA_KEY);

      List<EmployeeDetailsHive> employeeList = [];

      if (getExistingHiveData != null) {
        employeeList = getExistingHiveData.cast<EmployeeDetailsHive>();
        employeeList = employeeList.map((item) {
          if (item.employeeID == event.updatedEmployee.employeeID) {
            final updatedTasks = event.updatedEmployee.employeeTaskList.map(
              (task) {
                return EmployeeTaskHive(
                  taskTitle: task.taskTitle,
                  taskDescription: task.taskDescription,
                  taskDuration: task.taskDuration,
                  employeeID: task.employeeID,
                  employeeCheckInTime: task.employeeCheckInTime,
                  employeeCheckOutTime: task.employeeCheckOutTime,
                  isDone: task.isDone,
                );
              },
            ).toList();

            final updatedTasksDone =
                event.updatedEmployee.tasksDone.map((taskDone) {
              return TasksDoneHive(
                employeeID: taskDone.employeeID,
                isDone: taskDone.isDone,
                taskID: taskDone.taskID,
              );
            }).toList();

            return EmployeeDetailsHive(
              employeeID: event.updatedEmployee.employeeID,
              employeeFirstName: event.updatedEmployee.employeeFirstName,
              employeeLastName: event.updatedEmployee.employeeLastName,
              employeeEmail: event.updatedEmployee.employeeEmail,
              employeeRole: event.updatedEmployee.employeeRole,
              tasksDone: updatedTasksDone,
              employeeDateJoined: event.updatedEmployee.employeeDateJoined,
              employeeTaskList: updatedTasks,
            );
          }
          return item;
        }).toList();
      }

      await box.put(
        HiveEmployeeDetailsProperties.TO_EMPLOYEE_DETAILS_DATA_KEY,
        employeeList,
      );

      emit(
        EmployeeManagementLoaded(
          employeeDataList: List.from(_employeeList),
        ),
      );
    }
  }

  Future<void> _onAddEmployeeTask(
    AddEmployeeTask event,
    Emitter<EmployeeManagementState> emit,
  ) async {
    final employee = _employeeList.firstWhere(
      (e) => e.employeeID == event.employeeID,
      orElse: () => throw StateError("Employee not found"),
    );

    final updatedTasks = List<EmployeeTaskModel>.from(employee.employeeTaskList)
      ..add(event.task);

    final updatedEmployee = EmployeeModel(
      employeeID: employee.employeeID,
      employeeFirstName: employee.employeeFirstName,
      employeeLastName: employee.employeeLastName,
      employeeEmail: employee.employeeEmail,
      employeeRole: employee.employeeRole,
      tasksDone: employee.tasksDone,
      employeeDateJoined: employee.employeeDateJoined,
      employeeTaskList: updatedTasks,
    );

    final box = await Hive.openBox(
        HiveEmployeeDetailsProperties.TO_EMPLOYEE_DETAILS_DATA_BOX);
    final existingTaskData = List<EmployeeDetailsHive>.from(
        box.get(HiveEmployeeDetailsProperties.TO_EMPLOYEE_DETAILS_DATA_KEY) ??
            []);

    final employeeDataHive = existingTaskData.map((model) {
      if (model.employeeID == updatedEmployee.employeeID) {
        return EmployeeDetailsHive(
          employeeID: updatedEmployee.employeeID,
          employeeFirstName: updatedEmployee.employeeFirstName,
          employeeLastName: updatedEmployee.employeeLastName,
          employeeEmail: updatedEmployee.employeeEmail,
          employeeRole: updatedEmployee.employeeRole,
          tasksDone: updatedEmployee.tasksDone.map((taskDone) {
            return TasksDoneHive(
              employeeID: taskDone.employeeID,
              isDone: taskDone.isDone,
              taskID: taskDone.taskID,
            );
          }).toList(),
          employeeDateJoined: updatedEmployee.employeeDateJoined,
          employeeTaskList: updatedTasks.map((task) {
            return EmployeeTaskHive(
              taskTitle: task.taskTitle,
              taskDescription: task.taskDescription,
              taskDuration: task.taskDuration,
              employeeID: task.employeeID,
              employeeCheckInTime: task.employeeCheckInTime,
              employeeCheckOutTime: task.employeeCheckOutTime,
              isDone: task.isDone,
            );
          }).toList(),
        );
      }
      return model;
    }).toList();

    await box.put(
      HiveEmployeeDetailsProperties.TO_EMPLOYEE_DETAILS_DATA_KEY,
      employeeDataHive,
    );

    _employeeList[_employeeList.indexWhere(
      (e) => e.employeeID == updatedEmployee.employeeID,
    )] = updatedEmployee;

    emit(EmployeeManagementLoaded(employeeDataList: List.from(_employeeList)));
  }

  Future<void> _onRemoveEmployeeTask(
    RemoveEmployeeTask event,
    Emitter<EmployeeManagementState> emit,
  ) async {
    final employeeIndex = _employeeList.indexWhere(
      (e) => e.employeeID == event.employeeID,
    );

    final currentEmployee = _employeeList[employeeIndex];

    final updatedTasks =
        List<EmployeeTaskModel>.from(currentEmployee.employeeTaskList)
          ..removeWhere((task) => task.taskTitle == event.taskTitle);

    final updatedCurrentEmployee = EmployeeModel(
      employeeID: currentEmployee.employeeID,
      employeeFirstName: currentEmployee.employeeFirstName,
      employeeLastName: currentEmployee.employeeLastName,
      employeeEmail: currentEmployee.employeeEmail,
      employeeRole: currentEmployee.employeeRole,
      tasksDone: currentEmployee.tasksDone,
      employeeDateJoined: currentEmployee.employeeDateJoined,
      employeeTaskList: updatedTasks,
    );

    _employeeList[employeeIndex] = updatedCurrentEmployee;

    final box = await Hive.openBox(
      HiveEmployeeDetailsProperties.TO_EMPLOYEE_DETAILS_DATA_BOX,
    );

    final existingData = List<EmployeeDetailsHive>.from(
      box.get(HiveEmployeeDetailsProperties.TO_EMPLOYEE_DETAILS_DATA_KEY) ?? [],
    );

    final employeeDataHive = existingData.map((employeeHive) {
      if (employeeHive.employeeID == updatedCurrentEmployee.employeeID) {
        return EmployeeDetailsHive(
          employeeID: updatedCurrentEmployee.employeeID,
          employeeFirstName: updatedCurrentEmployee.employeeFirstName,
          employeeLastName: updatedCurrentEmployee.employeeLastName,
          employeeEmail: updatedCurrentEmployee.employeeEmail,
          employeeRole: updatedCurrentEmployee.employeeRole,
          tasksDone: updatedCurrentEmployee.tasksDone.map((taskDone) {
            return TasksDoneHive(
              employeeID: taskDone.employeeID,
              isDone: taskDone.isDone,
              taskID: taskDone.taskID,
            );
          }).toList(),
          employeeDateJoined: updatedCurrentEmployee.employeeDateJoined,
          employeeTaskList: updatedTasks.map((task) {
            return EmployeeTaskHive(
              taskTitle: task.taskTitle,
              taskDescription: task.taskDescription,
              taskDuration: task.taskDuration,
              employeeID: task.employeeID,
              employeeCheckInTime: task.employeeCheckInTime,
              employeeCheckOutTime: task.employeeCheckOutTime,
              isDone: task.isDone,
            );
          }).toList(),
        );
      }
      return employeeHive;
    }).toList();

    await box.put(
      HiveEmployeeDetailsProperties.TO_EMPLOYEE_DETAILS_DATA_KEY,
      employeeDataHive,
    );

    emit(EmployeeManagementLoaded(employeeDataList: List.from(_employeeList)));
  }

  Future<void> _onUpdateEmployeeTask(
    UpdateEmployeeTask event,
    Emitter<EmployeeManagementState> emit,
  ) async {
    final employeeIndex = _employeeList.indexWhere(
      (e) => e.employeeID == event.employeeID,
    );

    if (employeeIndex == -1) {
      return;
    }

    final employee = _employeeList[employeeIndex];

    final String taskID = event.updatedTask.taskID ?? "";

    bool isTaskNewlyCompleted = event.updatedTask.isDone &&
        !employee.tasksDone.any((task) => task.taskID == taskID);

    final updatedTasks = employee.employeeTaskList.map((task) {
      if (task.taskID == taskID) {
        return event.updatedTask;
      }
      return task;
    }).toList();

    List<TaskDoneModel> updatedTasksDone =
        List<TaskDoneModel>.from(employee.tasksDone);

    if (isTaskNewlyCompleted) {
      updatedTasksDone.add(TaskDoneModel(
        employeeID: employee.employeeID,
        isDone: true,
        taskID: taskID,
      ));
    }

    final updatedEmployee = EmployeeModel(
      employeeID: employee.employeeID,
      employeeFirstName: employee.employeeFirstName,
      employeeLastName: employee.employeeLastName,
      employeeEmail: employee.employeeEmail,
      employeeRole: employee.employeeRole,
      tasksDone: updatedTasksDone,
      employeeDateJoined: employee.employeeDateJoined,
      employeeTaskList: updatedTasks,
    );

    final box = await Hive.openBox(
      HiveEmployeeDetailsProperties.TO_EMPLOYEE_DETAILS_DATA_BOX,
    );
    final existingData = List<EmployeeDetailsHive>.from(
      box.get(HiveEmployeeDetailsProperties.TO_EMPLOYEE_DETAILS_DATA_KEY) ?? [],
    );

    final employeeDataHive = existingData.map((employeeHive) {
      if (employeeHive.employeeID == updatedEmployee.employeeID) {
        return EmployeeDetailsHive(
          employeeID: updatedEmployee.employeeID,
          employeeFirstName: updatedEmployee.employeeFirstName,
          employeeLastName: updatedEmployee.employeeLastName,
          employeeEmail: updatedEmployee.employeeEmail,
          employeeRole: updatedEmployee.employeeRole,
          tasksDone: updatedTasksDone.map((task) {
            return TasksDoneHive(
              employeeID: task.employeeID,
              isDone: task.isDone,
              taskID: task.taskID,
            );
          }).toList(),
          employeeDateJoined: updatedEmployee.employeeDateJoined,
          employeeTaskList: updatedTasks.map((task) {
            return EmployeeTaskHive(
              taskTitle: task.taskTitle,
              taskDescription: task.taskDescription,
              taskDuration: task.taskDuration,
              employeeID: task.employeeID,
              employeeCheckInTime: task.employeeCheckInTime,
              employeeCheckOutTime: task.employeeCheckOutTime,
              isDone: task.isDone,
            );
          }).toList(),
        );
      }
      return employeeHive;
    }).toList();

    await box.put(
      HiveEmployeeDetailsProperties.TO_EMPLOYEE_DETAILS_DATA_KEY,
      employeeDataHive,
    );

    _employeeList[employeeIndex] = updatedEmployee;

    emit(EmployeeManagementLoaded(employeeDataList: List.from(_employeeList)));
  }
}
