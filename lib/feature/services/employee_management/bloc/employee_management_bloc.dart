import 'package:bloc/bloc.dart';
import 'package:business_manager/core/storage_hive/hive_properites.dart';
import 'package:business_manager/feature/services/employee_management/data/hive/employee_details_hive.dart';
import 'package:business_manager/feature/services/employee_management/data/hive/employee_task_hive.dart';
import 'package:business_manager/feature/services/employee_management/models/employee_model.dart';
import 'package:business_manager/feature/services/employee_management/models/employee_task_model.dart';
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
    on<MarkTaskAsDone>(_onMarkAsDoneTask);
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
    print("Loaded: $_employeeList");
    emit(EmployeeManagementLoading());

    Box box = await Hive.openBox(
        HiveEmployeeDetailsProperties.TO_EMPLOYEE_DETAILS_DATA_BOX);

    final List<dynamic>? employeeListHive = await box
        .get(HiveEmployeeDetailsProperties.TO_EMPLOYEE_DETAILS_DATA_KEY);

    print(await box.keys);
    print(await box.values);
    debugPrint("Loaded: $_employeeList");
    _employeeList.clear();
    print("Loaded: $_employeeList");
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
        return EmployeeModel(
          employeeID: employeeModelHive.employeeID,
            employeeFirstName: employeeModelHive.employeeFirstName,
            employeeLastName: employeeModelHive.employeeLastName,
            employeeEmail: employeeModelHive.employeeEmail,
            employeeRole: employeeModelHive.employeeRole,
            employeeHourlyRate: employeeModelHive.employeeHourlyRate,
            employeeDateJoined: employeeModelHive.employeeDateJoined,
            employeeTaskList: taskList);
      }).toList();
      // print("Adding employee: ${event.employee}");
      print("Loaded: $_employeeList");
      _employeeList.addAll(employeeModel);
      emit(
          EmployeeManagementLoaded(employeeDataList: List.from(_employeeList)));
    }
    else {
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
        box.get(HiveToDoListProperties.TO_DO_LIST_DATA_KEY);
    List<EmployeeDetailsHive> employeeList = [];
    _employeeList.add(event.employee);
    if (getExistingHiveData != null) {
      employeeList = getExistingHiveData.cast<EmployeeDetailsHive>();
    }
    employeeList.add(EmployeeDetailsHive(
     employeeID: event.employee.employeeID,
      employeeFirstName: event.employee.employeeFirstName,
      employeeLastName: event.employee.employeeLastName,
      employeeEmail: event.employee.employeeEmail,
      employeeRole: event.employee.employeeRole,
      employeeHourlyRate: event.employee.employeeHourlyRate,
      employeeDateJoined: event.employee.employeeDateJoined,
      employeeTaskList: event.employee.employeeTaskList.map((task) {
        return EmployeeTaskHive(
          // taskID: task.taskID,
          taskTitle: task.taskTitle,
          taskDescription: task.taskDescription,
          taskDuration: task.taskDuration,
          employeeID: task.employeeID,
          employeeCheckInTime: task.employeeCheckInTime,
          employeeCheckOutTime: task.employeeCheckOutTime,
          isDone: task.isDone,
        );
      }).toList(),
    ));

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
        box.get(HiveToDoListProperties.TO_DO_LIST_DATA_KEY);

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
    final index = _employeeList.indexWhere((employee) =>
        employee.employeeEmail == event.updatedEmployee.employeeEmail);
    if (index != -1) {
      _employeeList[index] = event.updatedEmployee;
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
    final updatedEmployee = EmployeeModel(
      employeeID: employee.employeeID,
      employeeFirstName: employee.employeeFirstName,
      employeeLastName: employee.employeeLastName,
      employeeEmail: employee.employeeEmail,
      employeeRole: employee.employeeRole,
      employeeHourlyRate: employee.employeeHourlyRate,
      employeeDateJoined: employee.employeeDateJoined,
      employeeTaskList: List.from(employee.employeeTaskList)..add(event.task),
    );
    add(UpdateEmployee(updatedEmployee: updatedEmployee));
  }

  Future<void> _onRemoveEmployeeTask(
    RemoveEmployeeTask event,
    Emitter<EmployeeManagementState> emit,
  ) async {
    final employee = _employeeList.firstWhere(
      (e) => e.employeeID == event.employeeID,
      orElse: () => throw StateError("Employee not found"),
    );
    final updatedEmployee = EmployeeModel(
      employeeID: employee.employeeID,
      employeeFirstName: employee.employeeFirstName,
      employeeLastName: employee.employeeLastName,
      employeeEmail: employee.employeeEmail,
      employeeRole: employee.employeeRole,
      employeeHourlyRate: employee.employeeHourlyRate,
      employeeDateJoined: employee.employeeDateJoined,
      employeeTaskList: List.from(employee.employeeTaskList)
        ..removeWhere((task) => task.taskTitle == event.taskTitle),
    );
    add(UpdateEmployee(updatedEmployee: updatedEmployee));
  }

  Future<void> _onMarkAsDoneTask(
    MarkTaskAsDone event,
    Emitter<EmployeeManagementState> emit,
  ) async {
    final employee = _employeeList.firstWhere(
      (e) => e.employeeID == event.employeeID,
      orElse: () => throw StateError("Employee not found"),
    );
    final updatedTasks = employee.employeeTaskList.map((task) {
      if (task.taskTitle == event.taskTitle) {
        return EmployeeTaskModel(
          taskTitle: task.taskTitle,
          taskDescription: task.taskDescription,
          taskDuration: task.taskDuration,
          employeeID: employee.employeeID!,
          employeeCheckInTime: task.employeeCheckInTime,
          employeeCheckOutTime: task.employeeCheckOutTime,
          isDone: true,
        );
      }
      return task;
    }).toList();

    final updatedEmployee = EmployeeModel(
      employeeID: employee.employeeID,
      employeeFirstName: employee.employeeFirstName,
      employeeLastName: employee.employeeLastName,
      employeeEmail: employee.employeeEmail,
      employeeRole: employee.employeeRole,
      employeeHourlyRate: employee.employeeHourlyRate,
      employeeDateJoined: employee.employeeDateJoined,
      employeeTaskList: updatedTasks,
    );
    add(UpdateEmployee(updatedEmployee: updatedEmployee));
  }

  Future<void> _onUpdateEmployeeTask(
    UpdateEmployeeTask event,
    Emitter<EmployeeManagementState> emit,
  ) async {
    final employee = _employeeList.firstWhere(
      (e) => e.employeeID == event.employeeID,
      orElse: () => throw StateError("Employee not found"),
    );

    final updatedTasks = employee.employeeTaskList.map((task) {
      if (task.taskTitle == event.updatedTask.taskTitle) {
        return event.updatedTask;
      }
      return task;
    }).toList();

    final updatedEmployee = EmployeeModel(
      employeeID: employee.employeeID,
      employeeFirstName: employee.employeeFirstName,
      employeeLastName: employee.employeeLastName,
      employeeEmail: employee.employeeEmail,
      employeeRole: employee.employeeRole,
      employeeHourlyRate: employee.employeeHourlyRate,
      employeeDateJoined: employee.employeeDateJoined,
      employeeTaskList: updatedTasks,
    );

    add(UpdateEmployee(updatedEmployee: updatedEmployee));
  }
}
