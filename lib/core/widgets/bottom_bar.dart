import 'package:dissertation_project_app/core/main_utils/app_routes/app_routes.dart';
import 'package:dissertation_project_app/core/theme/colors.dart';
import 'package:dissertation_project_app/main.dart';
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
      backgroundColor: Pallete.colorThree,
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
          icon: Icon(Icons.cloud),
          label: 'Weather',
        ),
      ],
      currentIndex: widget.indexValue,
      selectedItemColor: Colors.amber,
      unselectedItemColor: Colors.red,
      onTap: (index) {
        switch (index) {
          case 0:
            MainApp.navigatorKey.currentState!.pushNamed(AppRoutes.homePage);
            break;
          case 1:
            MainApp.navigatorKey.currentState!.pushNamed(AppRoutes.toDoPage);
            break;

          case 2:
            MainApp.navigatorKey.currentState!.pushNamed(AppRoutes.weatherPage);
            break;
        }
      },
    );
  }
}
