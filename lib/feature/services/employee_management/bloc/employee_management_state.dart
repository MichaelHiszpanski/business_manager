part of 'employee_management_bloc.dart';

@immutable
sealed class EmployeeManagementState {}

final class EmployeeManagementInitial extends EmployeeManagementState {}

final class EmployeeManagementLoading extends EmployeeManagementState {}

final class EmployeeManagementLoaded extends EmployeeManagementState {
  final List<EmployeeModel> employeeDataList;

  EmployeeManagementLoaded({
    required this.employeeDataList,
  });

  @override
  List<Object> get props => [employeeDataList];
}

final class EmployeeManagementError extends EmployeeManagementState {}
