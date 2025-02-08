import 'package:business_manager/core/screens/informations_screen.dart';
import 'package:business_manager/core/screens/load_app_data_screen.dart';
import 'package:business_manager/feature/auth/profile/profile_screen.dart';
import 'package:business_manager/feature/auth/sign_in/sign_in_screen.dart';
import 'package:business_manager/feature/services/employee_management/presentation/screens/employee_add_new_screen.dart';
import 'package:business_manager/feature/services/employee_management/presentation/screens/employee_details_screen.dart';
import 'package:business_manager/feature/services/employee_management/presentation/screens/employee_management_screen.dart';
import 'package:business_manager/feature/services/invoice_manager/presentation/screens/invoice_manager_screen.dart';
import 'package:business_manager/feature/services/invoice_manager/presentation/screens/invoices_list_screen.dart';
import 'package:business_manager/feature/services/to_do_list/presentation/screens/add_item_screen.dart';
import 'package:business_manager/feature/services/to_do_list/presentation/screens/to_do_list_screen.dart';
import 'package:business_manager/feature/services/work_manager/presentation/screens/add_new_event_screen.dart';
import 'package:business_manager/feature/services/work_manager/presentation/screens/work_manager_screen.dart';
import 'package:flutter/material.dart';
import 'package:business_manager/core/screens/home_screen.dart';

class AppRoutes {
  static const String homePage = '/home_page';
  static const String loadAppDataScreen = '/core/screens/load_app_data_screen';
  static const String informationScreen = '/core/screens/informations_screen';
  static const String signIn = '/core/screens/sign_in';
  static const String profile = '/core/screens/profile_screen';

  //TO-DO LIST
  static const String toDoScreen =
      '/services/to_do_list/presentation/screens/to_do_list_screen';
  static const String addItemScreen =
      '/services/to_do_list/presentation/screens/add_item_screen';

  //WORK-MANAGER
  static const String workManagerScreen =
      '/services/work_manager/presentation/screens/work_manager_screen';

  static const String addNewEventScreen =
      '/services/work_manager/presentation/screens/add_new_event_screen';

  //INVOICE-MANAGER
  static const String invoiceManagerScreen =
      '/services/invoice_manager/presentation/screens/invoice_manager';
  static const String invoicesListScreen =
  '/services/invoice_manager/presentation/screens/invoices_list_screen';

  //Employee Management
  static const String employeeManagementScreen =
      '/services/employee_management/presentation/screens/employee_management_screen.dart';
  static const String employeeDetailsScreen =
      '/services/employee_management/presentation/screens/employee_details_screen.dart';
  static const String employeeAddNewScreen =
      '/services/employee_management/presentation/screens/employee_add_new_screen.dart';

  static final routes = <String, WidgetBuilder>{
    homePage: (context) => const HomePage(title: "Home Page"),
    toDoScreen: (context) => const ToDoListScreen(),
    signIn: (context) => const SignInScreen(),
    profile: (context) => const ProfileScreen(),
    addItemScreen: (context) => AddItemScreen(),
    loadAppDataScreen: (context) => const LoadAppDataScreen(),
    workManagerScreen: (context) => const WorkManagerScreen(),
    addNewEventScreen: (context) => const AddNewEventScreen(
          isLastDateVisible: true,
        ),
    invoiceManagerScreen: (context) => const InvoiceManagerScreen(),
    invoicesListScreen:(context)=>const InvoicesListScreen(),
    informationScreen: (context) => const InformationsScreen(),
    employeeManagementScreen: (context) => const EmployeeManagementScreen(),
    employeeDetailsScreen: (context) => const EmployeeDetailsScreen(),
    employeeAddNewScreen: (context) => const EmployeeAddNewScreen(),
  };
}
