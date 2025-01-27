import 'package:business_manager/core/main_utils/app_routes/app_routes.dart';
import 'package:business_manager/core/tools/constants.dart';
import 'package:business_manager/core/tools/flutter_helper.dart';

import 'package:business_manager/core/widgets/buttons/custom_side_button_menu/custom_side_button_menu.dart';
import 'package:business_manager/feature/services/to_do_list/presentation/widgets/custom_floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../theme/app_font_family.dart';
import '../../main.dart';

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({super.key, required this.title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
  bool isUserSignedIn = false;

  @override
  @override
  void initState() {
    super.initState();
    _initializeNotifications();
    _checkUserSignInStatus();
  }

  Future<void> _initializeNotifications() async {
    await Permission.notification.request();
  }

  Future<void> _checkUserSignInStatus() async {
    final user = Supabase.instance.client.auth.currentUser;
    setState(() {
      isUserSignedIn = user != null;
    });
  }

  void _handleProfile() {
    MainApp.navigatorKey.currentState!.pushNamed(AppRoutes.profile);
  }

  Future<void> _handleLogout() async {
    await Supabase.instance.client.auth.signOut();
    setState(() {
      isUserSignedIn = false;
    });
  }

  void _handleFloatingActionButtonPress() {
    if (isUserSignedIn) {
      // MainApp.navigatorKey.currentState!.pushNamed(AppRoutes.profilePage);
    } else {
      MainApp.navigatorKey.currentState!.pushNamed(AppRoutes.signIn);
    }
  }

  void _showDropdownMenu(BuildContext context) {
    showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(100, 0, 85, 100),
      menuPadding: const EdgeInsets.all(Constants.padding8),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.radius15),
      ),
      color: Colors.black38,
      popUpAnimationStyle: AnimationStyle(
          curve: Curves.easeInOutSine,
          duration: const Duration(milliseconds: 500),
          reverseDuration: const Duration(seconds: 1)),
      items: [
        PopupMenuItem(
          value: 'profile',
          child: Text(
            'Profile',
            style: context.text.titleSmall?.copyWith(
                fontFamily: AppFontFamily.orbitron, color: Colors.white),
          ),
        ),
        PopupMenuItem(
          value: 'logout',
          child: Text(
            'Log Out',
            style: context.text.titleSmall?.copyWith(
                fontFamily: AppFontFamily.orbitron, color: Colors.white),
          ),
        ),
      ],
    ).then((value) {
      if (value == 'profile') {
        _handleProfile();
      } else if (value == 'logout') {
        _handleLogout();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/home4.png',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Business Manager",
                  style: context.text.headlineLarge,
                ),
                CustomSideButtonMenu(
                  isUserSignedIn: isUserSignedIn,
                ),
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 20,
            right: 20,
            child: isUserSignedIn
                ? CustomFloatingActionButton(
                    icon: Icons.person,
                    onPressed: () => _showDropdownMenu(context),
                    heroTag: "heroTagHome",
                  )
                : CustomFloatingActionButton(
                    icon: Icons.login,
                    onPressed: _handleFloatingActionButtonPress,
                    heroTag: "heroTagHome",
                  ),
          ),
        ],
      ),
    );
  }
}
