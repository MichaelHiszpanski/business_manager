part of 'employee_management_bloc.dart';

@immutable
sealed class EmployeeManagementEvent extends Equatable {
  const EmployeeManagementEvent();

  @override
  List<Object?> get props => [];
}

class InitialEmployeeManagement extends EmployeeManagementEvent {
  const InitialEmployeeManagement();
}

class AddEmployee extends EmployeeManagementEvent {
  final EmployeeModel employee;

  const AddEmployee({required this.employee});

  @override
  List<Object?> get props => [employee];
}

class RemoveEmployee extends EmployeeManagementEvent {
  final String employeeID;

  const RemoveEmployee({required this.employeeID});

  @override
  List<Object?> get props => [employeeID];
}

class UpdateEmployee extends EmployeeManagementEvent {
  final EmployeeModel updatedEmployee;

  const UpdateEmployee({required this.updatedEmployee});

  @override
  List<Object?> get props => [updatedEmployee];
}

class LoadEmployeeList extends EmployeeManagementEvent {
  const LoadEmployeeList();
}

class AddEmployeeTask extends EmployeeManagementEvent {
  final String employeeID;
  final EmployeeTaskModel task;

  const AddEmployeeTask({required this.employeeID, required this.task});

  @override
  List<Object?> get props => [employeeID, task];
}

class RemoveEmployeeTask extends EmployeeManagementEvent {
  final String employeeID;
  final String taskTitle;

  const RemoveEmployeeTask({required this.employeeID, required this.taskTitle});

  @override
  List<Object?> get props => [employeeID, taskTitle];
}
class UpdateEmployeeTask extends EmployeeManagementEvent {
  final String employeeID;
  final EmployeeTaskModel updatedTask;

  const UpdateEmployeeTask({
    required this.employeeID,
    required this.updatedTask,
  });

  @override
  List<Object?> get props => [employeeID, updatedTask];
}


class CheckForOverdueTasks extends EmployeeManagementEvent {
  const CheckForOverdueTasks();

  @override
  List<Object?> get props => [];
}
