import 'package:business_manager/core/main_utils/main_bloc/main_bloc.dart';
import 'package:business_manager/feature/services/employee_management/bloc/employee_management_bloc.dart';
import 'package:business_manager/feature/services/invoice_manager/bloc/invoice_manager_bloc.dart';
import 'package:business_manager/feature/services/to_do_list/bloc/to_do_bloc.dart';
import 'package:business_manager/feature/services/work_manager/bloc/work_manager_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocProviders extends StatelessWidget {
  final Widget child;

  const AppBlocProviders({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MainBloc()),
        BlocProvider(create: (context) => ToDoBloc()),
        BlocProvider(create: (context) => WorkManagerBloc()),
        BlocProvider(create: (context) => InvoiceManagerBloc()),
        BlocProvider(create: (context) => EmployeeManagementBloc()),
      ],
      child: child,
    );
  }
}
