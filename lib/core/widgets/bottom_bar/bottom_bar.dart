import 'package:business_manager/core/main_utils/app_routes/app_routes.dart';
import 'package:business_manager/core/theme/colors.dart';
import 'package:business_manager/main.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key, required this.indexValue}) : super(key: key);

  final int indexValue;

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Pallete.colorOne,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'To-Do List',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.work_history),
          label: 'Work Manager',
        ),
      ],
      currentIndex: widget.indexValue,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.red,
      onTap: (index) {
        switch (index) {
          case 0:
            MainApp.navigatorKey.currentState!.pushNamed(AppRoutes.homePage);
            break;
          case 1:
            MainApp.navigatorKey.currentState!.pushNamed(AppRoutes.toDoScreen);
            break;

          case 2:
            MainApp.navigatorKey.currentState!.pushNamed(AppRoutes.workManagerScreen);
            break;
        }
      },
    );
  }
}
