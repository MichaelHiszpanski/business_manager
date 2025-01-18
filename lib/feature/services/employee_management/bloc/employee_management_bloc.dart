import 'package:bloc/bloc.dart';
import 'package:business_manager/feature/services/employee_management/models/employee_model.dart';
import 'package:business_manager/feature/services/employee_management/models/employee_task_model.dart';
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
    on<UpdateEmployeeTask>((event, emit) async {
      final employee = _employeeList.firstWhere(
        (e) => e.employeeID == event.employeeID,
        orElse: () => throw StateError("Employee not found"),
      );

      // Update the task within the employee's task list
      final updatedTasks = employee.employeeTaskList.map((task) {
        if (task.taskTitle == event.updatedTask.taskTitle) {
          return event.updatedTask;
        }
        return task;
      }).toList();

      // Create an updated employee with the modified task list
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

      // Emit the updated state
      add(UpdateEmployee(updatedEmployee: updatedEmployee));
    });
  }

  Future<void> _onInitialLoad(
    InitialEmployeeManagement event,
    Emitter<EmployeeManagementState> emit,
  ) async {
    emit(EmployeeManagementInitial());
  }

  Future<void> _onAddEmployee(
    AddEmployee event,
    Emitter<EmployeeManagementState> emit,
  ) async {
    _employeeList.add(event.employee);
    emit(EmployeeManagementLoaded(employeeDataList: List.from(_employeeList)));
  }

  // Future<void> _onRemoveEmployee(
  //     RemoveEmployee event,
  //     Emitter<EmployeeManagementState> emit,
  //     ) async {
  //   _employeeList.removeWhere(
  //           (employee) => employee.employeeEmail == event.employeeEmail);
  //   emit(EmployeeManagementLoaded(employeeDataList: List.from(_employeeList)));
  // }
  Future<void> _onRemoveEmployee(
    RemoveEmployee event,
    Emitter<EmployeeManagementState> emit,
  ) async {
    _employeeList
        .removeWhere((employee) => employee.employeeID == event.employeeID);
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

  Future<void> _onLoadedEmployeeList(
    LoadEmployeeList event,
    Emitter<EmployeeManagementState> emit,
  ) async {
    emit(EmployeeManagementLoaded(employeeDataList: List.from(_employeeList)));
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
}
