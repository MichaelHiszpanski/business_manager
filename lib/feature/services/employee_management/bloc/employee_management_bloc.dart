import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'employee_management_event.dart';
part 'employee_management_state.dart';

class EmployeeManagementBloc extends Bloc<EmployeeManagementEvent, EmployeeManagementState> {
  EmployeeManagementBloc() : super(EmployeeManagementInitial()) {
    on<EmployeeManagementEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
