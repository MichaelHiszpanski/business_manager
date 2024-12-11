import 'package:business_manager/core/screens/informations_screen.dart';
import 'package:business_manager/core/screens/load_app_data_screen.dart';
import 'package:business_manager/core/screens/sign_in_screen.dart';
import 'package:business_manager/feature/services/invoice_manager/presentation/screens/add_business_owner_screen.dart';
import 'package:business_manager/feature/services/invoice_manager/presentation/screens/invoice_manager_screen.dart';
import 'package:business_manager/feature/services/to_do_list/presentation/screens/add_item_page.dart';
import 'package:business_manager/feature/services/to_do_list/presentation/screens/to_do_list_screen.dart';
import 'package:business_manager/feature/services/work_manager/presentation/screens/add_new_event_screen.dart';
import 'package:business_manager/feature/services/work_manager/presentation/screens/work_manager_screen.dart';
import 'package:flutter/material.dart';
import 'package:business_manager/home_page.dart';

class AppRoutes {
  static const String homePage = '/home_page';
  static const String loadAppDataScreen = '/core/screens/load_app_data_screen';
  static const String informationScreen = '/core/screens/informations_screen';
  static const String signIn = '/core/screens/sign_in';

  //TO-DO LIST
  static const String toDoPage =
      '/services/to_do_list/presentation/screens/to_do_page';
  static const String addItemPage =
      '/services/to_do_list/presentation/screens/add_item_page';

  //WORK-MANAGER
  static const String workManagerScreen =
      '/services/work_manager/presentation/screens/work_manager_screen';

  static const String addNewEventScreen =
      '/services/work_manager/presentation/screens/add_new_event_screen';

  //INVOICE-MANAGER
  static const String invoiceManagerScreen =
      '/services/invoice_manager/presentation/screens/invoice_manager';
  static const String addBusinessOwnerScreen =
      '/services/invoice_manager/presentation/screens/add_business_owner_screen.dart';

  static final routes = <String, WidgetBuilder>{
    homePage: (context) => const HomePage(title: "Home Page"),
    toDoPage: (context) => const ToDoListScreen(),
    signIn: (context) => const SignInScreen(),
    addItemPage: (context) => AddItemPage(),
    loadAppDataScreen: (context) => const LoadAppDataScreen(),
    workManagerScreen: (context) => const WorkManagerScreen(),
    addNewEventScreen: (context) => const AddNewEventScreen(
          isLastDateVisible: true,
        ),
    invoiceManagerScreen: (context) => const InvoiceManagerScreen(),
    informationScreen: (context) => const InformationsScreen(),
    addBusinessOwnerScreen: (context) => const AddBusinessOwnerScreen(),
  };
}
