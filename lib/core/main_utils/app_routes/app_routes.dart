import 'package:business_manager/core/screens/load_app_data_screen.dart';
import 'package:business_manager/core/screens/test_screen.dart';
import 'package:business_manager/feature/services/to_do_list/presentation/screens/add_item_page.dart';
import 'package:business_manager/feature/services/to_do_list/presentation/screens/to_do_page.dart';
import 'package:business_manager/feature/services/work_manager/presentation/screens/add_new_event_screen.dart';
import 'package:business_manager/feature/services/work_manager/presentation/screens/work_manager_screen.dart';
import 'package:flutter/material.dart';
import 'package:business_manager/home_page.dart';

class AppRoutes {
  static const String homePage = '/home_page';
  static const String toDoPage =
      '/services/to_do_list/presentation/screens/to_do_page';
  static const String addItemPage =
      '/services/to_do_list/presentation/screens/add_item_page';
  static const String loadAppDataScreen = '/core/screens/load_app_data_screen';
  static const String testScreen = '/core/screens/test_screen';

  //WORK-MANAGER
  static const String workManagerScreen =
      '/services/work_manager/presentation/work_manager_screen';

  static const String addNewEventScreen =
      '/services/work_manager/presentation/add_new_event_screen';

  static final routes = <String, WidgetBuilder>{
    homePage: (context) => const HomePage(title: "Home Page"),
    toDoPage: (context) => const ToDoPage(),
    addItemPage: (context) => AddItemPage(),
    loadAppDataScreen: (context) => const LoadAppDataScreen(),
    testScreen: (context) => RotatingCirclesScreen(),
    workManagerScreen: (context) => const WorkManagerScreen(),
    addNewEventScreen: (context) => const AddNewEventScreen(
          isLastDateVisible: true,
        )
  };
}
