import 'package:business_manager/core/main_utils/app_routes/app_routes.dart';
import 'package:business_manager/core/main_utils/bloc_provider/bloc_provider.dart';
import 'package:business_manager/core/storage_hive/hive_register_adapter.dart';
import 'package:business_manager/core/theme/text_styles.dart';
import 'package:business_manager/home_page.dart';
import 'package:business_manager/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timezone/data/latest.dart' as tz;

Future<void> main() async {
  tz.initializeTimeZones();

  await HiveRegisterAdapter.register();

  Bloc.observer = AppBlocObserver();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return
        // AppRepositories(
        //   child:
        AppBlocProviders(
      child: MaterialApp(
        navigatorKey: navigatorKey,
        initialRoute: '/home_page',
        theme: customTheme,
        // localizationsDelegates: AppLocalizations.localizationsDelegates,
        // supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('en'),
        routes: AppRoutes.routes,
        home: Scaffold(
          body: Center(child: HomePage(title: "")),
        ),
      ),
      //)
    );
  }
}
